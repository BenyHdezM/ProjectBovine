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
                                        .map((foto) => _PhotoThumb(
                                              path: foto.rutaFoto,
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
                    _SectionLabel('Identificación'),
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
                    _SectionLabel('Estado'),
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
                    _SectionLabel('Nacimiento'),
                    _InfoRow(
                      icon: Icons.cake_outlined,
                      label: 'Fecha de nacimiento',
                      value: b.fechaNacimiento != null
                          ? '${dateFormat.format(b.fechaNacimiento!)}  ·  ${_calcularEdadTexto(b.fechaNacimiento!)}'
                          : 'No especificada',
                    ),
                    const SizedBox(height: 12),

                    // ── Clasificación ────────────────────────────────────
                    _SectionLabel('Clasificación'),
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
                    _SectionLabel('Dueño actual'),
                    _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Dueño',
                      value: item.dueno?.nombre ?? 'Sin dueño registrado',
                    ),
                    const SizedBox(height: 12),

                    // ── Registro ─────────────────────────────────────────
                    _SectionLabel('Registro'),
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

class _PhotoThumb extends StatelessWidget {
  final String path;
  const _PhotoThumb({required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
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
    );
  }
}
