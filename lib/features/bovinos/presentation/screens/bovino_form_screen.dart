import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';
import '../providers/bovinos_providers.dart';

class BovinoFormScreen extends ConsumerStatefulWidget {
  final Bovino? bovino; // null = nuevo

  const BovinoFormScreen({super.key, this.bovino});

  @override
  ConsumerState<BovinoFormScreen> createState() => _BovinoFormScreenState();
}

class _BovinoFormScreenState extends ConsumerState<BovinoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('dd/MM/yyyy');

  late final TextEditingController _areteCtrl;
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _uppCtrl;

  String _sexo = 'H';
  String _estado = 'activo';
  DateTime? _fechaNacimiento;
  DateTime? _fechaMuerte;
  DateTime? _fechaVenta;
  int? _loteId;
  int? _razaId;
  int? _duenoId;

  bool get _esEdicion => widget.bovino != null;

  @override
  void initState() {
    super.initState();
    final b = widget.bovino;
    _areteCtrl = TextEditingController(text: b?.areteId ?? '');
    _nombreCtrl = TextEditingController(text: b?.nombre ?? '');
    _uppCtrl = TextEditingController(text: b?.upp ?? '');
    if (b != null) {
      _sexo = b.sexo;
      _estado = b.estado;
      _fechaNacimiento = b.fechaNacimiento;
      _fechaMuerte = b.fechaMuerte;
      _loteId = b.loteId;
      _razaId = b.razaId;
    }
  }

  @override
  void dispose() {
    _areteCtrl.dispose();
    _nombreCtrl.dispose();
    _uppCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context, {
    required _DateField field,
  }) async {
    final initial = switch (field) {
      _DateField.nacimiento => _fechaNacimiento ?? DateTime.now(),
      _DateField.muerte     => _fechaMuerte ?? DateTime.now(),
      _DateField.venta      => _fechaVenta ?? DateTime.now(),
    };
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        switch (field) {
          case _DateField.nacimiento: _fechaNacimiento = picked;
          case _DateField.muerte:     _fechaMuerte = picked;
          case _DateField.venta:      _fechaVenta = picked;
        }
      });
    }
  }

  Future<void> _deleteBovino(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Bovino'),
        content: const Text(
            '¿Estás seguro de eliminar este bovino? Se borrarán todas las vacunas, tratamientos y registros asociados.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text('Eliminar'),
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        final db = ref.read(appDatabaseProvider);
        await db.bovinosDao.deleteBovinoWithChildren(id);
        if (context.mounted) context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bovino eliminado')),
        );
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final companion = BovinosCompanion(
      areteId: Value(_areteCtrl.text.trim()),
      nombre: Value(_nombreCtrl.text.trim().isEmpty
          ? null
          : _nombreCtrl.text.trim()),
      sexo: Value(_sexo),
      estado: Value(_estado),
      fechaNacimiento: Value(_fechaNacimiento),
      fechaMuerte: Value(_estado == 'muerto' ? _fechaMuerte : null),
      loteId: Value(_loteId),
      razaId: Value(_razaId),
      upp: Value(_uppCtrl.text.trim().isEmpty ? null : _uppCtrl.text.trim()),
      updatedAt: Value(DateTime.now()),
    );

    final error = await ref
        .read(bovinoFormProvider.notifier)
        .save(
          bovino: companion,
          duenoId: _duenoId,
          editId: widget.bovino?.id,
          fechaVenta: _estado == 'vendido' ? _fechaVenta : null,
        );

    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final lotesAsync = ref.watch(lotesListProvider);
    final razasAsync = ref.watch(razasListProvider);
    final duenosAsync = ref.watch(duenosListProvider);
    final isLoading = ref.watch(bovinoFormProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Bovino' : 'Nuevo Bovino'),
        actions: _esEdicion
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Eliminar',
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => _deleteBovino(widget.bovino!.id),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Arete ID ────────────────────────────────────────────────
                TextFormField(
                  controller: _areteCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Arete ID *',
                    prefixIcon: Icon(Icons.tag),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16),

                // ── Nombre ───────────────────────────────────────────────────
                TextFormField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: Icon(Icons.pets),
                    helperText: 'Opcional — debe ser único',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 20),

                // ── Sexo ─────────────────────────────────────────────────────
                const Text('Sexo *',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'H', label: Text('Hembra (H)')),
                    ButtonSegment(value: 'M', label: Text('Macho (M)')),
                  ],
                  selected: {_sexo},
                  onSelectionChanged: (v) => setState(() => _sexo = v.first),
                ),
                const SizedBox(height: 20),

                // ── Fecha de nacimiento ───────────────────────────────────────
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cake_outlined),
                  title: const Text('Fecha de nacimiento'),
                  subtitle: Text(
                    _fechaNacimiento != null
                        ? _dateFormat.format(_fechaNacimiento!)
                        : 'No especificada',
                  ),
                  onTap: () => _pickDate(context, field: _DateField.nacimiento),
                ),
                const Divider(),

                // ── Lote ──────────────────────────────────────────────────────
                lotesAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const SizedBox(),
                  data: (lotes) => DropdownButtonFormField<int>(
                    value: _loteId,
                    decoration: const InputDecoration(
                      labelText: 'Lote',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: lotes
                        .map((l) => DropdownMenuItem(
                              value: l.id,
                              child: Text('${l.clave} — ${l.descripcion ?? ''}'),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _loteId = v),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Raza ──────────────────────────────────────────────────────
                razasAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const SizedBox(),
                  data: (razas) => razas.isEmpty
                      ? OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar razas primero'),
                          onPressed: null,
                        )
                      : DropdownButtonFormField<int>(
                          value: _razaId,
                          decoration: const InputDecoration(
                            labelText: 'Raza',
                            prefixIcon: Icon(Icons.biotech_outlined),
                          ),
                          items: razas
                              .map((r) => DropdownMenuItem(
                                    value: r.id,
                                    child: Text(r.nombre),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => _razaId = v),
                        ),
                ),
                const SizedBox(height: 16),

                // ── UPP ───────────────────────────────────────────────────────
                TextFormField(
                  controller: _uppCtrl,
                  decoration: const InputDecoration(
                    labelText: 'UPP',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    helperText: 'Unidad de Producción Pecuaria',
                  ),
                ),
                const SizedBox(height: 16),

                // ── Dueño ─────────────────────────────────────────────────────
                duenosAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const SizedBox(),
                  data: (duenos) => Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _duenoId,
                          decoration: InputDecoration(
                            labelText: _esEdicion
                                ? 'Cambiar dueño'
                                : 'Dueño *',
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          items: duenos
                              .map((d) => DropdownMenuItem(
                                    value: d.id,
                                    child: Text(d.nombre),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => _duenoId = v),
                          validator: _esEdicion
                              ? null
                              : (v) => v == null ? 'Selecciona un dueño' : null,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_add_outlined),
                        tooltip: 'Nuevo dueño',
                        onPressed: () => context.push('/duenos/new'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Estado (solo en edición) ──────────────────────────────────
                if (_esEdicion) ...[
                  const Text('Estado *',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'activo', label: Text('Activo')),
                      ButtonSegment(value: 'vendido', label: Text('Vendido')),
                      ButtonSegment(value: 'muerto', label: Text('Muerto')),
                    ],
                    selected: {_estado},
                    onSelectionChanged: (v) =>
                        setState(() => _estado = v.first),
                  ),
                  if (_estado == 'muerto') ...[
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.event_busy_outlined),
                      title: const Text('Fecha de muerte'),
                      subtitle: Text(
                        _fechaMuerte != null
                            ? _dateFormat.format(_fechaMuerte!)
                            : 'No especificada',
                      ),
                      onTap: () => _pickDate(context, field: _DateField.muerte),
                    ),
                  ],
                  if (_estado == 'vendido') ...[
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.sell_outlined),
                      title: const Text('Fecha de venta'),
                      subtitle: Text(
                        _fechaVenta != null
                            ? _dateFormat.format(_fechaVenta!)
                            : 'No especificada',
                      ),
                      onTap: () => _pickDate(context, field: _DateField.venta),
                    ),
                  ],
                  const SizedBox(height: 20),
                ],

                // ── Botones ────────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: isLoading ? null : _submit,
                        icon: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(isLoading
                            ? 'Guardando…'
                            : _esEdicion
                                ? 'Guardar cambios'
                                : 'Registrar Bovino'),
                      ),
                    ),
                    if (_esEdicion) ...[
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => _deleteBovino(widget.bovino!.id),
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Eliminar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _DateField { nacimiento, muerte, venta }
