import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/bovino_with_dueno.dart';
import '../providers/bovinos_providers.dart';

class BovinoDetailScreen extends ConsumerWidget {
  final BovinoWithDueno item;

  const BovinoDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = item.bovino;
    final fotosAsync = ref.watch(fotosByBovinoProvider(b.id));
    final lotesAsync = ref.watch(lotesListProvider);
    final razasAsync = ref.watch(razasListProvider);

    final lote = lotesAsync.value?.where((l) => l.id == b.loteId).firstOrNull;
    final raza = razasAsync.value?.where((r) => r.id == b.razaId).firstOrNull;

    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(b.nombre ?? b.areteId),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
            onPressed: () =>
                context.push('/bovinos/${b.id}', extra: b),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final hPad = constraints.maxWidth > 600 ? 24.0 : 20.0;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Fotos ─────────────────────────────────────────────
                    fotosAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (fotos) => fotos.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fotos',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 110,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: fotos
                                        .asMap()
                                        .entries
                                        .map((e) => _PhotoThumb(
                                              path: e.value.rutaFoto,
                                              onTap: () => _showPhotoViewer(
                                                context,
                                                fotos
                                                    .map((f) => f.rutaFoto)
                                                    .toList(),
                                                e.key,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Divider(),
                                const SizedBox(height: 12),
                              ],
                            ),
                    ),

                    // ── Identificación ───────────────────────────────────
                    const _SectionLabel('Identificación'),
                    _InfoRow(
                      icon: Icons.tag,
                      label: 'Arete ID',
                      value: b.areteId,
                    ),
                    if (b.numRegistro != null)
                      _InfoRow(
                        icon: Icons.numbers_outlined,
                        label: 'Núm. Registro',
                        value: b.numRegistro!,
                      ),
                    if (b.nombre != null)
                      _InfoRow(
                        icon: Icons.pets,
                        label: 'Nombre',
                        value: b.nombre!,
                      ),
                    _InfoRow(
                      icon: b.sexo == 'H'
                          ? Icons.female_outlined
                          : Icons.male_outlined,
                      label: 'Sexo',
                      value: b.sexo == 'H' ? 'Hembra' : 'Macho',
                    ),
                    const SizedBox(height: 12),

                    // ── Estado ───────────────────────────────────────────
                    const _SectionLabel('Estado'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 14,
                            color: switch (b.estado) {
                              'vendido' => Colors.orange,
                              'muerto' => Colors.grey,
                              _ => Colors.green,
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            switch (b.estado) {
                              'vendido' => 'Vendido',
                              'muerto' => 'Muerto',
                              _ => 'Activo',
                            },
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    if (b.estado == 'muerto' && b.fechaMuerte != null)
                      _InfoRow(
                        icon: Icons.event_busy_outlined,
                        label: 'Fecha de muerte',
                        value: dateFormat.format(b.fechaMuerte!),
                      ),
                    const SizedBox(height: 12),

                    // ── Nacimiento ───────────────────────────────────────
                    const _SectionLabel('Nacimiento'),
                    _InfoRow(
                      icon: Icons.cake_outlined,
                      label: 'Fecha de nacimiento',
                      value: b.fechaNacimiento != null
                          ? '${dateFormat.format(b.fechaNacimiento!)}  ·  ${_calcularEdadTexto(b.fechaNacimiento!)}'
                          : 'No especificada',
                    ),
                    const SizedBox(height: 12),

                    // ── Clasificación ────────────────────────────────────
                    const _SectionLabel('Clasificación'),
                    _InfoRow(
                      icon: Icons.category_outlined,
                      label: 'Lote',
                      value: lote != null
                          ? '${lote.clave} — ${lote.descripcion ?? ''}'
                          : 'Sin lote',
                    ),
                    _InfoRow(
                      icon: Icons.biotech_outlined,
                      label: 'Raza',
                      value: raza?.nombre ?? 'Sin raza',
                    ),
                    if (b.upp != null)
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        label: 'UPP',
                        value: b.upp!,
                      ),
                    const SizedBox(height: 12),

                    // ── Propiedad ────────────────────────────────────────
                    const _SectionLabel('Dueño actual'),
                    _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Dueño',
                      value: item.dueno?.nombre ?? 'Sin dueño registrado',
                    ),
                    const SizedBox(height: 12),

                    // ── Partos (solo hembras) ─────────────────────────────
                    if (b.sexo == 'H') _PartosSection(bovinoId: b.id),

                    // ── Registro ─────────────────────────────────────────
                    const _SectionLabel('Registro'),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Registrado',
                      value: dateFormat.format(b.createdAt),
                    ),
                    if (b.updatedAt != b.createdAt)
                      _InfoRow(
                        icon: Icons.update_outlined,
                        label: 'Última actualización',
                        value: dateFormat.format(b.updatedAt),
                      ),
                    const SizedBox(height: 24),

                    // ── Botón editar ─────────────────────────────────────
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.push('/bovinos/${b.id}', extra: b),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar bovino'),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String _calcularEdadTexto(DateTime fechaNacimiento) {
  final hoy = DateTime.now();
  int edad = hoy.year - fechaNacimiento.year;
  if (hoy.month < fechaNacimiento.month ||
      (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
    edad--;
  }
  if (edad < 0) edad = 0;
  return '$edad ${edad == 1 ? 'año' : 'años'}';
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.outline),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(height: 2),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Partos ───────────────────────────────────────────────────────────────────

class _PartosSection extends ConsumerWidget {
  final int bovinoId;

  const _PartosSection({required this.bovinoId});

  void _openDialog(BuildContext context, {Parto? existing}) {
    showDialog(
      context: context,
      builder: (_) => _PartoDialog(bovinoId: bovinoId, existing: existing),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar parto'),
        content: const Text('¿Confirmas eliminar este registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final error =
          await ref.read(partoFormProvider.notifier).deleteParto(id);
      if (error != null && context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partosAsync = ref.watch(partosByBovinoProvider(bovinoId));
    final fmt = DateFormat('dd/MM/yyyy');

    return partosAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (partos) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'PARTOS',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
              ),
              const Spacer(),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Agregar'),
                onPressed: () => _openDialog(context),
              ),
            ],
          ),
          if (partos.isNotEmpty) ...[
            _buildStats(context, partos, fmt),
            const SizedBox(height: 4),
          ],
          if (partos.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Sin partos registrados',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 13),
              ),
            )
          else
            ...partos.map((p) => _PartoTile(
                  parto: p,
                  fmt: fmt,
                  onEdit: () => _openDialog(context, existing: p),
                  onDelete: () => _confirmDelete(context, ref, p.id),
                )),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildStats(
      BuildContext context, List<Parto> partos, DateFormat fmt) {
    final total = partos.length;
    final ultimo = partos.first;

    String? intervalo;
    if (partos.length >= 2) {
      int totalDays = 0;
      for (int i = 0; i < partos.length - 1; i++) {
        totalDays += partos[i]
            .fechaParto
            .difference(partos[i + 1].fechaParto)
            .inDays
            .abs();
      }
      final avgMonths =
          (totalDays / (partos.length - 1) / 30.4).round();
      intervalo = '~$avgMonths meses';
    }

    final parts = [
      '$total ${total == 1 ? "parto" : "partos"}',
      'Último: ${fmt.format(ultimo.fechaParto)}',
      if (intervalo != null) 'Intervalo: $intervalo',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        parts.join('  ·  '),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }
}

class _PartoTile extends StatelessWidget {
  final Parto parto;
  final DateFormat fmt;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PartoTile({
    required this.parto,
    required this.fmt,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading:
          Icon(Icons.child_care_outlined, color: Theme.of(context).colorScheme.outline),
      title: Text(fmt.format(parto.fechaParto)),
      subtitle: parto.notas != null
          ? Text(parto.notas!, style: const TextStyle(fontSize: 12))
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18),
            tooltip: 'Editar',
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete_outline,
                size: 18,
                color: Theme.of(context).colorScheme.error),
            tooltip: 'Eliminar',
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _PartoDialog extends ConsumerStatefulWidget {
  final int bovinoId;
  final Parto? existing;

  const _PartoDialog({required this.bovinoId, this.existing});

  @override
  ConsumerState<_PartoDialog> createState() => _PartoDialogState();
}

class _PartoDialogState extends ConsumerState<_PartoDialog> {
  final _fmt = DateFormat('dd/MM/yyyy');
  DateTime? _fecha;
  late final TextEditingController _notasCtrl;

  @override
  void initState() {
    super.initState();
    _fecha = widget.existing?.fechaParto;
    _notasCtrl = TextEditingController(text: widget.existing?.notas ?? '');
  }

  @override
  void dispose() {
    _notasCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _fecha = picked);
  }

  Future<void> _save() async {
    if (_fecha == null) return;
    final error = await ref.read(partoFormProvider.notifier).saveParto(
          bovinoId: widget.bovinoId,
          fechaParto: _fecha!,
          notas: _notasCtrl.text.trim().isEmpty
              ? null
              : _notasCtrl.text.trim(),
          editId: widget.existing?.id,
        );
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(partoFormProvider).isLoading;

    return AlertDialog(
      title: Text(
          widget.existing == null ? 'Registrar parto' : 'Editar parto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.calendar_month_outlined,
              color: _fecha == null
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
            title: const Text('Fecha del parto *'),
            subtitle: Text(
              _fecha != null ? _fmt.format(_fecha!) : 'Toca para seleccionar',
              style: _fecha == null
                  ? TextStyle(
                      color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            onTap: _pickDate,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notasCtrl,
            decoration: const InputDecoration(
              labelText: 'Notas',
              hintText: 'Opcional',
              prefixIcon: Icon(Icons.notes_outlined),
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: (isLoading || _fecha == null) ? null : _save,
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(
                  widget.existing == null ? 'Registrar' : 'Guardar'),
        ),
      ],
    );
  }
}

// ─── Fotos viewer ─────────────────────────────────────────────────────────────

void _showPhotoViewer(
    BuildContext context, List<String> paths, int initialIndex) {
  showDialog(
    context: context,
    barrierColor: Colors.black,
    builder: (_) =>
        _PhotoViewerDialog(paths: paths, initialIndex: initialIndex),
  );
}

class _PhotoThumb extends StatelessWidget {
  final String path;
  final VoidCallback? onTap;
  const _PhotoThumb({required this.path, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
            image: FileImage(File(path)),
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
      ),
    );
  }
}

class _PhotoViewerDialog extends StatefulWidget {
  final List<String> paths;
  final int initialIndex;

  const _PhotoViewerDialog(
      {required this.paths, required this.initialIndex});

  @override
  State<_PhotoViewerDialog> createState() => _PhotoViewerDialogState();
}

class _PhotoViewerDialogState extends State<_PhotoViewerDialog> {
  late final PageController _pageCtrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _pageCtrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageCtrl,
            itemCount: widget.paths.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Center(
                child: Image(
                  image: FileImage(File(widget.paths[i])),
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image_outlined,
                    color: Colors.white38,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black45,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          if (widget.paths.length > 1)
            Positioned(
              bottom: 28,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.paths.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _current == i ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _current == i ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
