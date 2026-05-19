import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
