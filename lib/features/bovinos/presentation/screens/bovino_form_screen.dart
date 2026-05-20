import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/bovino_with_dueno.dart';
import '../../../../core/utils/text_formatters.dart';
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
  final _picker = ImagePicker();

  late final TextEditingController _areteCtrl;
  late final TextEditingController _numRegistroCtrl;
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

  int? _madreId;
  int? _padreId;

  final List<File> _newPhotoFiles = [];
  final Set<int> _deletedPhotoIds = {};

  bool _showErrors = false;

  bool get _esEdicion => widget.bovino != null;

  @override
  void initState() {
    super.initState();
    final b = widget.bovino;
    _areteCtrl = TextEditingController(text: b?.areteId ?? '');
    _numRegistroCtrl = TextEditingController(text: b?.numRegistro ?? '');
    _nombreCtrl = TextEditingController(text: b?.nombre ?? '');
    _uppCtrl = TextEditingController(text: b?.upp ?? '');
    if (b != null) {
      _sexo = b.sexo;
      _estado = b.estado;
      _fechaNacimiento = b.fechaNacimiento;
      _fechaMuerte = b.fechaMuerte;
      _loteId = b.loteId;
      _razaId = b.razaId;
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadProgenie());
    }
  }

  @override
  void dispose() {
    _areteCtrl.dispose();
    _numRegistroCtrl.dispose();
    _nombreCtrl.dispose();
    _uppCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProgenie() async {
    final p = await ref
        .read(bovinoFormProvider.notifier)
        .getProgenie(widget.bovino!.id);
    if (p != null && mounted) {
      setState(() {
        _madreId = p.madreId;
        _padreId = p.padreId;
      });
    }
  }

  Future<void> _openBovinoSearch(
    BuildContext context, {
    required String label,
    required List<BovinoWithDueno> candidates,
    required ValueChanged<int?> onSelected,
  }) async {
    final result = await showModalBottomSheet<BovinoWithDueno>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _BovinoSearchSheet(label: label, candidates: candidates),
    );
    if (result != null && mounted) {
      onSelected(result.bovino.id);
    }
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

  Future<void> _pickFromCamera() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _newPhotoFiles.add(File(picked.path)));
    }
  }

  Future<void> _pickFromGallery() async {
    final picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isNotEmpty) {
      setState(() => _newPhotoFiles.addAll(picked.map((x) => File(x.path))));
    }
  }

  void _showPhotoSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Cámara'),
              onTap: () {
                Navigator.pop(ctx);
                _pickFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Galería'),
              onTap: () {
                Navigator.pop(ctx);
                _pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
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
      final error =
          await ref.read(bovinoFormProvider.notifier).deleteBovino(id);
      if (!mounted) return;
      if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al eliminar: $error')));
        return;
      }
      if (context.mounted) context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bovino eliminado')),
      );
    }
  }

  Future<void> _submit() async {
    setState(() => _showErrors = true);
    if (!_formKey.currentState!.validate()) return;
    if (_fechaNacimiento == null) return;
    if (_estado == 'muerto' && _fechaMuerte == null) return;
    if (_estado == 'vendido' && _fechaVenta == null) return;

    final companion = BovinosCompanion(
      areteId: Value(_areteCtrl.text.trim()),
      numRegistro: Value(_numRegistroCtrl.text.trim().isEmpty
          ? null
          : _numRegistroCtrl.text.trim()),
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
          madreId: _madreId,
          padreId: _padreId,
          newPhotoFiles: _newPhotoFiles,
          deletedPhotoIds: _deletedPhotoIds.toList(),
        );

    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    context.pop();
  }

  Widget _buildFotosSection(AsyncValue<List<Foto>>? fotosAsync) {
    final existingPhotos = _esEdicion
        ? (fotosAsync?.value ?? [])
            .where((f) => !_deletedPhotoIds.contains(f.id))
            .toList()
        : <Foto>[];
    final isEmpty = existingPhotos.isEmpty && _newPhotoFiles.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Fotos',
                style: TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.add_a_photo_outlined, size: 18),
              label: const Text('Agregar'),
              onPressed: _showPhotoSourceSheet,
            ),
          ],
        ),
        if (isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'Sin fotos — toca Agregar para subir una',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 13),
              ),
            ),
          )
        else
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...existingPhotos.map((foto) => _PhotoThumb(
                      imageProvider: FileImage(File(foto.rutaFoto)),
                      onDelete: () =>
                          setState(() => _deletedPhotoIds.add(foto.id)),
                    )),
                ..._newPhotoFiles.map((file) => _PhotoThumb(
                      imageProvider: FileImage(file),
                      isNew: true,
                      onDelete: () =>
                          setState(() => _newPhotoFiles.remove(file)),
                    )),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lotesAsync = ref.watch(lotesListProvider);
    final razasAsync = ref.watch(razasListProvider);
    final duenosAsync = ref.watch(duenosListProvider);
    final bovinos = ref.watch(bovinosListProvider).value ?? [];
    final isLoading = ref.watch(bovinoFormProvider).isLoading;
    final fotosAsync = _esEdicion
        ? ref.watch(fotosByBovinoProvider(widget.bovino!.id))
        : null;

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final hPad = constraints.maxWidth > 600 ? 24.0 : 20.0;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
            child: Center(
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                // ── Fotos ─────────────────────────────────────────────────────
                _buildFotosSection(fotosAsync),
                const Divider(),
                const SizedBox(height: 12),

                // ── Arete ID ────────────────────────────────────────────────
                TextFormField(
                  controller: _areteCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Arete ID',
                    prefixIcon: Icon(Icons.tag),
                    helperText: 'Opcional — debe ser único',
                  ),
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [NoAccentFormatter()],
                ),
                const SizedBox(height: 16),

                // ── Núm. Registro ────────────────────────────────────────────
                TextFormField(
                  controller: _numRegistroCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Núm. Registro *',
                    prefixIcon: Icon(Icons.numbers_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  inputFormatters: [NoAccentFormatter()],
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
                  leading: Icon(
                    Icons.cake_outlined,
                    color: (_showErrors && _fechaNacimiento == null)
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
                  title: const Text('Fecha de nacimiento *'),
                  subtitle: Text(
                    _fechaNacimiento != null
                        ? _dateFormat.format(_fechaNacimiento!)
                        : (_showErrors ? 'Requerida' : 'No especificada'),
                    style: (_showErrors && _fechaNacimiento == null)
                        ? TextStyle(color: Theme.of(context).colorScheme.error)
                        : null,
                  ),
                  onTap: () => _pickDate(context, field: _DateField.nacimiento),
                ),
                const Divider(),

                // ── Lote ──────────────────────────────────────────────────────
                lotesAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const SizedBox(),
                  data: (lotes) => Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          initialValue: _loteId,
                          decoration: const InputDecoration(
                            labelText: 'Lote',
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          items: lotes
                              .map((l) => DropdownMenuItem(
                                    value: l.id,
                                    child: Text(
                                        '${l.clave} — ${l.descripcion ?? ''}'),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => _loteId = v),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_box_outlined),
                        tooltip: 'Nuevo lote',
                        onPressed: () => context.push('/lotes/new'),
                      ),
                    ],
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
                          initialValue: _razaId,
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
                    helperText: 'Unidad de Produccion Pecuaria',
                  ),
                  inputFormatters: [NoAccentFormatter()],
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
                          initialValue: _duenoId,
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

                // ── Progenie ──────────────────────────────────────────────────
                const Text('Progenie',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                _ProgenitorTile(
                  label: 'Vaca Madre',
                  icon: Icons.female_outlined,
                  value: _getBovinoLabel(_madreId, bovinos),
                  onTap: () => _openBovinoSearch(
                    context,
                    label: 'Vaca Madre',
                    candidates: bovinos
                        .where((b) =>
                            b.bovino.sexo == 'H' &&
                            b.bovino.id != widget.bovino?.id)
                        .toList(),
                    onSelected: (id) => setState(() => _madreId = id),
                  ),
                  onClear: _madreId != null
                      ? () => setState(() => _madreId = null)
                      : null,
                ),
                _ProgenitorTile(
                  label: 'Toro Padre',
                  icon: Icons.male_outlined,
                  value: _getBovinoLabel(_padreId, bovinos),
                  onTap: () => _openBovinoSearch(
                    context,
                    label: 'Toro Padre',
                    candidates: bovinos
                        .where((b) =>
                            b.bovino.sexo == 'M' &&
                            b.bovino.id != widget.bovino?.id)
                        .toList(),
                    onSelected: (id) => setState(() => _padreId = id),
                  ),
                  onClear: _padreId != null
                      ? () => setState(() => _padreId = null)
                      : null,
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
                    onSelectionChanged: (v) => setState(() {
                      _estado = v.first;
                      if (_estado == 'activo') {
                        _fechaMuerte = null;
                        _fechaVenta = null;
                        _showErrors = false;
                      }
                    }),
                  ),
                  if (_estado == 'muerto') ...[
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.event_busy_outlined,
                        color: (_showErrors && _fechaMuerte == null)
                            ? Theme.of(context).colorScheme.error
                            : null,
                      ),
                      title: const Text('Fecha de muerte *'),
                      subtitle: Text(
                        _fechaMuerte != null
                            ? _dateFormat.format(_fechaMuerte!)
                            : (_showErrors
                                ? 'Requerida'
                                : 'No especificada'),
                        style: (_showErrors && _fechaMuerte == null)
                            ? TextStyle(
                                color: Theme.of(context).colorScheme.error)
                            : null,
                      ),
                      onTap: () => _pickDate(context, field: _DateField.muerte),
                    ),
                  ],
                  if (_estado == 'vendido') ...[
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.sell_outlined,
                        color: (_showErrors && _fechaVenta == null)
                            ? Theme.of(context).colorScheme.error
                            : null,
                      ),
                      title: const Text('Fecha de venta *'),
                      subtitle: Text(
                        _fechaVenta != null
                            ? _dateFormat.format(_fechaVenta!)
                            : (_showErrors
                                ? 'Requerida'
                                : 'No especificada'),
                        style: (_showErrors && _fechaVenta == null)
                            ? TextStyle(
                                color: Theme.of(context).colorScheme.error)
                            : null,
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
        },
      ),
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({
    required this.imageProvider,
    required this.onDelete,
    this.isNew = false,
  });

  final ImageProvider imageProvider;
  final VoidCallback onDelete;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: imageProvider,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: Colors.grey.shade200,
                child: const Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
          if (isNew)
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Nueva',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _DateField { nacimiento, muerte, venta }

String? _getBovinoLabel(int? id, List<BovinoWithDueno> list) {
  if (id == null) return null;
  final item = list.where((b) => b.bovino.id == id).firstOrNull;
  if (item == null) return null;
  final b = item.bovino;
  final identifier =
      b.areteId.isNotEmpty ? b.areteId : b.numRegistro ?? '';
  if (b.nombre != null && b.nombre!.isNotEmpty) {
    return identifier.isNotEmpty ? '${b.nombre} — $identifier' : b.nombre!;
  }
  return identifier.isNotEmpty ? identifier : '#${b.id}';
}

class _ProgenitorTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _ProgenitorTile({
    required this.label,
    required this.icon,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon,
          color: Theme.of(context).colorScheme.onSurfaceVariant),
      title: Text(label),
      subtitle: Text(
        value ?? 'Sin selección',
        style: value == null
            ? TextStyle(color: Theme.of(context).colorScheme.outline)
            : null,
      ),
      trailing: onClear != null
          ? IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Quitar',
              onPressed: onClear,
            )
          : const Icon(Icons.search_outlined),
      onTap: onTap,
    );
  }
}

class _BovinoSearchSheet extends StatefulWidget {
  final String label;
  final List<BovinoWithDueno> candidates;

  const _BovinoSearchSheet({
    required this.label,
    required this.candidates,
  });

  @override
  State<_BovinoSearchSheet> createState() => _BovinoSearchSheetState();
}

class _BovinoSearchSheetState extends State<_BovinoSearchSheet> {
  final _searchCtrl = TextEditingController();
  late List<BovinoWithDueno> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.candidates;
    _searchCtrl.addListener(_filter);
  }

  void _filter() {
    final q = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? widget.candidates
          : widget.candidates.where((item) {
              final b = item.bovino;
              return b.areteId.toLowerCase().contains(q) ||
                  (b.nombre?.toLowerCase().contains(q) ?? false) ||
                  (b.numRegistro?.toLowerCase().contains(q) ?? false);
            }).toList();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollCtrl) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              'Seleccionar ${widget.label}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Buscar por arete, núm. registro o nombre…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _searchCtrl.clear,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_filtered.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Sin resultados',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.outline),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final item = _filtered[i];
                  final label = _getBovinoLabel(item.bovino.id,
                      [item]) ?? item.bovino.areteId;
                  return ListTile(
                    title: Text(label),
                    subtitle: item.dueno != null
                        ? Text(item.dueno!.nombre,
                            style: const TextStyle(fontSize: 12))
                        : null,
                    onTap: () => Navigator.pop(ctx, item),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
