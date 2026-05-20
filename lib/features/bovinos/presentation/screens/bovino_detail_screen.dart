import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/bovino_with_dueno.dart';
import '../providers/bovinos_providers.dart';

// ─── Main screen ──────────────────────────────────────────────────────────────

class BovinoDetailScreen extends ConsumerWidget {
  final BovinoWithDueno item;

  const BovinoDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = item.bovino;
    final fotosAsync = ref.watch(fotosByBovinoProvider(b.id));
    final lote = ref
        .watch(lotesListProvider)
        .value
        ?.where((l) => l.id == b.loteId)
        .firstOrNull;
    final raza = ref
        .watch(razasListProvider)
        .value
        ?.where((r) => r.id == b.razaId)
        .firstOrNull;
    final fmt = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          b.nombre ??
              (b.areteId.isNotEmpty ? b.areteId : 'Bovino #${b.id}'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
            onPressed: () => context.push('/bovinos/${b.id}', extra: b),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) => constraints.maxWidth >= 700
            ? _DesktopLayout(
                item: item,
                lote: lote,
                raza: raza,
                fmt: fmt,
                fotosAsync: fotosAsync,
              )
            : _MobileLayout(
                item: item,
                lote: lote,
                raza: raza,
                fmt: fmt,
                fotosAsync: fotosAsync,
              ),
      ),
    );
  }
}

// ─── Mobile layout ────────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final BovinoWithDueno item;
  final Lote? lote;
  final Raza? raza;
  final DateFormat fmt;
  final AsyncValue<List<Foto>> fotosAsync;

  const _MobileLayout({
    required this.item,
    required this.lote,
    required this.raza,
    required this.fmt,
    required this.fotosAsync,
  });

  @override
  Widget build(BuildContext context) {
    final b = item.bovino;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero
          _HeroSection(fotosAsync: fotosAsync, height: 220),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + estado
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        b.nombre ??
                            (b.areteId.isNotEmpty
                                ? b.areteId
                                : 'Bovino #${b.id}'),
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _EstadoChip(estado: b.estado),
                  ],
                ),
                const SizedBox(height: 10),

                // Quick stats
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _QuickStat(
                      icon: b.sexo == 'H' ? Icons.female : Icons.male,
                      label: b.sexo == 'H' ? 'Hembra' : 'Macho',
                    ),
                    if (b.fechaNacimiento != null)
                      _QuickStat(
                        icon: Icons.cake_outlined,
                        label: _calcularEdadTexto(b.fechaNacimiento!),
                      ),
                    if (item.dueno != null)
                      _QuickStat(
                        icon: Icons.person_outline,
                        label: item.dueno!.nombre,
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Identificación
                _InfoCard(
                  title: 'Identificación',
                  child: Column(
                    children: [
                      if (b.areteId.isNotEmpty)
                        _InfoRow(
                            icon: Icons.tag,
                            label: 'Arete ID',
                            value: b.areteId),
                      if (b.numRegistro != null)
                        _InfoRow(
                            icon: Icons.numbers_outlined,
                            label: 'Número de Control',
                            value: b.numRegistro!),
                      if (b.nombre != null)
                        _InfoRow(
                            icon: Icons.pets,
                            label: 'Nombre',
                            value: b.nombre!),
                      _InfoRow(
                        icon: b.sexo == 'H'
                            ? Icons.female_outlined
                            : Icons.male_outlined,
                        label: 'Sexo',
                        value: b.sexo == 'H' ? 'Hembra' : 'Macho',
                      ),
                      _InfoRow(
                        icon: Icons.cake_outlined,
                        label: 'Nacimiento',
                        value: b.fechaNacimiento != null
                            ? '${fmt.format(b.fechaNacimiento!)}  ·  ${_calcularEdadTexto(b.fechaNacimiento!)}'
                            : 'No especificada',
                        last: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Clasificación
                _InfoCard(
                  title: 'Clasificación',
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.category_outlined,
                        label: 'Lote',
                        value: lote != null
                            ? '${lote!.clave} — ${lote!.descripcion ?? ''}'
                            : 'Sin lote',
                      ),
                      _InfoRow(
                          icon: Icons.biotech_outlined,
                          label: 'Raza',
                          value: raza?.nombre ?? 'Sin raza'),
                      if (b.upp != null)
                        _InfoRow(
                            icon: Icons.location_on_outlined,
                            label: 'UPP',
                            value: b.upp!,
                            last: true),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Estado (solo si no activo)
                if (b.estado != 'activo') ...[
                  _InfoCard(
                    title: 'Estado',
                    child: Column(
                      children: [
                        if (b.estado == 'muerto' && b.fechaMuerte != null)
                          _InfoRow(
                            icon: Icons.event_busy_outlined,
                            label: 'Fecha de muerte',
                            value: fmt.format(b.fechaMuerte!),
                            last: true,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Partos y reproductivo (hembras)
                if (b.sexo == 'H') ...[
                  _InfoCard(
                    title: '',
                    child: _PartosSection(bovinoId: b.id),
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    title: '',
                    child: _RegistroSection(bovinoId: b.id),
                  ),
                  const SizedBox(height: 12),
                ],

                // Semental (machos)
                if (b.sexo == 'M') ...[
                  _InfoCard(
                    title: '',
                    child: _SementalSection(bovinoId: b.id),
                  ),
                  const SizedBox(height: 12),
                ],

                // Registro
                _InfoCard(
                  title: 'Registro',
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Registrado',
                        value: fmt.format(b.createdAt),
                      ),
                      _InfoRow(
                        icon: Icons.update_outlined,
                        label: 'Última modificación',
                        value: fmt.format(b.updatedAt),
                        last: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                OutlinedButton.icon(
                  onPressed: () =>
                      context.push('/bovinos/${b.id}', extra: b),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Editar bovino'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Desktop layout ───────────────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final BovinoWithDueno item;
  final Lote? lote;
  final Raza? raza;
  final DateFormat fmt;
  final AsyncValue<List<Foto>> fotosAsync;

  const _DesktopLayout({
    required this.item,
    required this.lote,
    required this.raza,
    required this.fmt,
    required this.fotosAsync,
  });

  @override
  Widget build(BuildContext context) {
    final b = item.bovino;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Left sidebar ────────────────────────────────────────────────────
        SizedBox(
          width: 280,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _HeroSection(fotosAsync: fotosAsync, height: 220),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  b.nombre ??
                      (b.areteId.isNotEmpty ? b.areteId : 'Bovino #${b.id}'),
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),

                // Estado + sexo chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _EstadoChip(estado: b.estado),
                    _QuickStat(
                      icon: b.sexo == 'H' ? Icons.female : Icons.male,
                      label: b.sexo == 'H' ? 'Hembra' : 'Macho',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: cs.outlineVariant),
                const SizedBox(height: 12),

                // Key info list
                if (b.areteId.isNotEmpty)
                  _SidebarInfo(
                      icon: Icons.tag,
                      label: 'Arete ID',
                      value: b.areteId),
                if (b.numRegistro != null)
                  _SidebarInfo(
                      icon: Icons.numbers_outlined,
                      label: 'Número de Control',
                      value: b.numRegistro!),
                if (b.fechaNacimiento != null)
                  _SidebarInfo(
                      icon: Icons.cake_outlined,
                      label: 'Edad',
                      value: _calcularEdadTexto(b.fechaNacimiento!)),
                _SidebarInfo(
                    icon: Icons.person_outline,
                    label: 'Dueño',
                    value: item.dueno?.nombre ?? 'Sin dueño registrado'),
                if (lote != null)
                  _SidebarInfo(
                      icon: Icons.category_outlined,
                      label: 'Lote',
                      value: '${lote!.clave} — ${lote!.descripcion ?? ''}'),
                if (raza != null)
                  _SidebarInfo(
                      icon: Icons.biotech_outlined,
                      label: 'Raza',
                      value: raza!.nombre),
                if (b.upp != null)
                  _SidebarInfo(
                      icon: Icons.location_on_outlined,
                      label: 'UPP',
                      value: b.upp!),

                const SizedBox(height: 20),

                FilledButton.icon(
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Editar bovino'),
                  onPressed: () =>
                      context.push('/bovinos/${b.id}', extra: b),
                ),
              ],
            ),
          ),
        ),

        // ── Vertical divider ────────────────────────────────────────────────
        VerticalDivider(width: 1, thickness: 1, color: cs.outlineVariant),

        // ── Right content ───────────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Identificación + Clasificación lado a lado si hay espacio
                  LayoutBuilder(
                    builder: (ctx, c) => c.maxWidth >= 560
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _InfoCard(
                                  title: 'Identificación',
                                  child: _identificacionContent(b, fmt),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _InfoCard(
                                  title: 'Clasificación',
                                  child: _clasificacionContent(b),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _InfoCard(
                                  title: 'Identificación',
                                  child: _identificacionContent(b, fmt)),
                              const SizedBox(height: 16),
                              _InfoCard(
                                  title: 'Clasificación',
                                  child: _clasificacionContent(b)),
                            ],
                          ),
                  ),
                  const SizedBox(height: 16),

                  // Estado extendido
                  if (b.estado != 'activo' &&
                      b.estado == 'muerto' &&
                      b.fechaMuerte != null) ...[
                    _InfoCard(
                      title: 'Estado',
                      child: _InfoRow(
                        icon: Icons.event_busy_outlined,
                        label: 'Fecha de muerte',
                        value: fmt.format(b.fechaMuerte!),
                        last: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Partos y reproductivo (hembras)
                  if (b.sexo == 'H') ...[
                    _InfoCard(title: '', child: _PartosSection(bovinoId: b.id)),
                    const SizedBox(height: 16),
                    _InfoCard(
                        title: '', child: _RegistroSection(bovinoId: b.id)),
                    const SizedBox(height: 16),
                  ],

                  // Semental (machos)
                  if (b.sexo == 'M') ...[
                    _InfoCard(
                        title: '', child: _SementalSection(bovinoId: b.id)),
                    const SizedBox(height: 16),
                  ],

                  // Registro
                  _InfoCard(
                    title: 'Registro',
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Registrado',
                          value: fmt.format(b.createdAt),
                        ),
                        _InfoRow(
                          icon: Icons.update_outlined,
                          label: 'Última modificación',
                          value: fmt.format(b.updatedAt),
                          last: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _identificacionContent(Bovino b, DateFormat fmt) => Column(
        children: [
          if (b.areteId.isNotEmpty)
            _InfoRow(icon: Icons.tag, label: 'Arete ID', value: b.areteId),
          if (b.nombre != null)
            _InfoRow(icon: Icons.pets, label: 'Nombre', value: b.nombre!),
          _InfoRow(
            icon: b.sexo == 'H' ? Icons.female_outlined : Icons.male_outlined,
            label: 'Sexo',
            value: b.sexo == 'H' ? 'Hembra' : 'Macho',
          ),
          _InfoRow(
            icon: Icons.cake_outlined,
            label: 'Nacimiento',
            value: b.fechaNacimiento != null
                ? '${fmt.format(b.fechaNacimiento!)}  ·  ${_calcularEdadTexto(b.fechaNacimiento!)}'
                : 'No especificada',
            last: true,
          ),
        ],
      );

  Widget _clasificacionContent(Bovino b) => Column(
        children: [
          _InfoRow(
            icon: Icons.category_outlined,
            label: 'Lote',
            value: lote != null
                ? '${lote!.clave} — ${lote!.descripcion ?? ''}'
                : 'Sin lote',
          ),
          _InfoRow(
              icon: Icons.biotech_outlined,
              label: 'Raza',
              value: raza?.nombre ?? 'Sin raza'),
          if (b.upp != null)
            _InfoRow(
                icon: Icons.location_on_outlined,
                label: 'UPP',
                value: b.upp!,
                last: true),
        ],
      );
}

// ─── Shared layout widgets ────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final AsyncValue<List<Foto>> fotosAsync;
  final double height;

  const _HeroSection({required this.fotosAsync, required this.height});

  @override
  Widget build(BuildContext context) {
    final fotos = fotosAsync.value ?? [];
    if (fotos.isEmpty) return _placeholder(context);

    return GestureDetector(
      onTap: () => _showPhotoViewer(
          context, fotos.map((f) => f.rutaFoto).toList(), 0),
      child: Stack(
        children: [
          Image.file(
            File(fotos.first.rutaFoto),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _placeholder(context),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.25)],
                ),
              ),
            ),
          ),
          if (fotos.length > 1)
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.photo_library_outlined,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text('${fotos.length}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(Icons.pets,
            size: 72, color: cs.onPrimaryContainer.withOpacity(0.35)),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class _EstadoChip extends StatelessWidget {
  final String estado;
  const _EstadoChip({required this.estado});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (estado) {
      'vendido' => (const Color(0xFFE65100), 'Vendido'),
      'muerto'  => (Colors.grey.shade600, 'Muerto'),
      _         => (const Color(0xFF2E7D32), 'Activo'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: cs.onSurfaceVariant),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _SidebarInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _SidebarInfo(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.outline),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.outline)),
                const SizedBox(height: 1),
                Text(value,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool last;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.outline),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.outline)),
                const SizedBox(height: 2),
                Text(value, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

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
              child: const Text('Cancelar')),
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
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
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
      leading: Icon(Icons.child_care_outlined,
          color: Theme.of(context).colorScheme.outline),
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
              onPressed: onEdit),
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
            leading: Icon(Icons.calendar_month_outlined,
                color: _fecha == null
                    ? Theme.of(context).colorScheme.error
                    : null),
            title: const Text('Fecha del parto *'),
            subtitle: Text(
              _fecha != null
                  ? _fmt.format(_fecha!)
                  : 'Toca para seleccionar',
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
            child: const Text('Cancelar')),
        FilledButton(
          onPressed: (isLoading || _fecha == null) ? null : _save,
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(widget.existing == null ? 'Registrar' : 'Guardar'),
        ),
      ],
    );
  }
}

// ─── Registro Reproductivo ────────────────────────────────────────────────────

(IconData, String) _tipoInfo(String tipo) => switch (tipo) {
      'monta' => (Icons.favorite_outline, 'Monta Natural'),
      'inseminacion' => (Icons.science_outlined, 'Inseminación IA'),
      'diagnostico_gestacion' => (Icons.search_outlined, 'Diagnóstico'),
      'secado' => (Icons.water_drop_outlined, 'Secado'),
      _ => (Icons.event_outlined, 'Otro'),
    };

class _RegistroSection extends ConsumerWidget {
  final int bovinoId;

  const _RegistroSection({required this.bovinoId});

  void _openDialog(BuildContext context,
      {RegistroReproductivoData? existing}) {
    showDialog(
      context: context,
      builder: (_) =>
          _RegistroDialog(bovinoId: bovinoId, existing: existing),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar evento'),
        content:
            const Text('¿Confirmas eliminar este registro reproductivo?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
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
          await ref.read(registroFormProvider.notifier).deleteRegistro(id);
      if (error != null && context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosAsync = ref.watch(registrosByBovinoProvider(bovinoId));
    final fmt = DateFormat('dd/MM/yyyy');

    return registrosAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (registros) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'REGISTRO REPRODUCTIVO',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
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
          if (registros.isNotEmpty) _buildProximoParto(context, registros, fmt),
          if (registros.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Sin eventos registrados',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 13),
              ),
            )
          else
            ...registros.map((r) => _RegistroTile(
                  registro: r,
                  fmt: fmt,
                  onEdit: () => _openDialog(context, existing: r),
                  onDelete: () => _confirmDelete(context, ref, r.id),
                )),
        ],
      ),
    );
  }

  Widget _buildProximoParto(BuildContext context,
      List<RegistroReproductivoData> registros, DateFormat fmt) {
    final now = DateTime.now();
    final upcoming = registros
        .where((r) =>
            r.fechaProbableParto != null &&
            r.fechaProbableParto!.isAfter(now))
        .toList();
    if (upcoming.isEmpty) return const SizedBox.shrink();
    final next = upcoming.reduce((a, b) =>
        a.fechaProbableParto!.isBefore(b.fechaProbableParto!) ? a : b);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        'Próximo parto estimado: ${fmt.format(next.fechaProbableParto!)}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _RegistroTile extends StatelessWidget {
  final RegistroReproductivoData registro;
  final DateFormat fmt;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _RegistroTile({
    required this.registro,
    required this.fmt,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, label) = _tipoInfo(registro.tipo);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Theme.of(context).colorScheme.outline),
      title: Text(label),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fmt.format(registro.fecha),
              style: const TextStyle(fontSize: 12)),
          if (registro.fechaProbableParto != null)
            Text(
              'Parto estimado: ${fmt.format(registro.fechaProbableParto!)}',
              style: const TextStyle(fontSize: 12),
            ),
          if (registro.diagnostico != null &&
              registro.diagnostico!.isNotEmpty)
            Text(registro.diagnostico!,
                style: const TextStyle(fontSize: 12)),
        ],
      ),
      isThreeLine: registro.fechaProbableParto != null ||
          (registro.diagnostico != null && registro.diagnostico!.isNotEmpty),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18),
              tooltip: 'Editar',
              onPressed: onEdit),
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

// ─── Semental ─────────────────────────────────────────────────────────────────

class _SementalSection extends ConsumerWidget {
  final int bovinoId;

  const _SementalSection({required this.bovinoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toroAsync = ref.watch(toroByBovinoProvider(bovinoId));
    final isLoading = ref.watch(toroNotifierProvider).isLoading;

    return toroAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (toro) {
        final isToro = toro != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SEMENTAL',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Designar como semental'),
              subtitle: Text(
                isToro
                    ? 'Disponible para seleccionar en montas'
                    : 'Activar para usar en registros de monta',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline),
              ),
              value: isToro,
              onChanged: isLoading
                  ? null
                  : (v) async {
                      final error = await ref
                          .read(toroNotifierProvider.notifier)
                          .toggleToro(bovinoId, enable: v);
                      if (error != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error)));
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}

// ─── Registro Dialog ──────────────────────────────────────────────────────────

class _RegistroDialog extends ConsumerStatefulWidget {
  final int bovinoId;
  final RegistroReproductivoData? existing;

  const _RegistroDialog({required this.bovinoId, this.existing});

  @override
  ConsumerState<_RegistroDialog> createState() => _RegistroDialogState();
}

class _RegistroDialogState extends ConsumerState<_RegistroDialog> {
  final _fmt = DateFormat('dd/MM/yyyy');
  late String _tipo;
  DateTime? _fecha;
  DateTime? _fechaProbableParto;
  bool _fechaPpManual = false;
  int? _toroId;
  late final TextEditingController _diagnosticoCtrl;
  bool _showErrors = false;

  static const _tipos = [
    ('monta', 'Monta Natural', Icons.favorite_outline),
    ('inseminacion', 'Inseminación IA', Icons.science_outlined),
    ('diagnostico_gestacion', 'Diagnóstico', Icons.search_outlined),
    ('secado', 'Secado', Icons.water_drop_outlined),
    ('otro', 'Otro', Icons.event_outlined),
  ];

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _tipo = e?.tipo ?? 'monta';
    _fecha = e?.fecha;
    _fechaProbableParto = e?.fechaProbableParto;
    _fechaPpManual = e?.fechaProbableParto != null;
    _toroId = e?.toroId;
    _diagnosticoCtrl = TextEditingController(text: e?.diagnostico ?? '');
  }

  @override
  void dispose() {
    _diagnosticoCtrl.dispose();
    super.dispose();
  }

  void _onTipoChanged(String tipo) {
    setState(() {
      _tipo = tipo;
      if (tipo == 'monta' || tipo == 'inseminacion') {
        if (!_fechaPpManual && _fecha != null) {
          _fechaProbableParto = _fecha!.add(const Duration(days: 283));
        }
      } else {
        _fechaProbableParto = null;
        _fechaPpManual = false;
      }
      if (tipo != 'monta') _toroId = null;
    });
  }

  void _onFechaChanged(DateTime fecha) {
    setState(() {
      _fecha = fecha;
      if (!_fechaPpManual &&
          (_tipo == 'monta' || _tipo == 'inseminacion')) {
        _fechaProbableParto = fecha.add(const Duration(days: 283));
      }
    });
  }

  Future<void> _pickFecha() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) _onFechaChanged(picked);
  }

  Future<void> _pickFechaPP() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaProbableParto ??
          DateTime.now().add(const Duration(days: 283)),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 500)),
    );
    if (picked != null) {
      setState(() {
        _fechaProbableParto = picked;
        _fechaPpManual = true;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _showErrors = true);
    if (_fecha == null) return;
    final error =
        await ref.read(registroFormProvider.notifier).saveRegistro(
              bovinoId: widget.bovinoId,
              tipo: _tipo,
              fecha: _fecha!,
              fechaProbableParto: _fechaProbableParto,
              toroId: _toroId,
              diagnostico: _diagnosticoCtrl.text.trim().isEmpty
                  ? null
                  : _diagnosticoCtrl.text.trim(),
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
    final isLoading = ref.watch(registroFormProvider).isLoading;
    final torosAsync = ref.watch(allTorosProvider);
    final bovinos = ref.watch(bovinosListProvider).value ?? [];

    String getToroLabel(int toroId) {
      final toro =
          torosAsync.value?.where((t) => t.id == toroId).firstOrNull;
      if (toro == null) return 'Toro #$toroId';
      final bd =
          bovinos.where((b) => b.bovino.id == toro.bovinoId).firstOrNull;
      if (bd == null) return 'Toro #$toroId';
      final b = bd.bovino;
      return b.nombre ??
          (b.areteId.isNotEmpty ? b.areteId : 'Bovino #${b.id}');
    }

    final showFechaPP = _tipo == 'monta' || _tipo == 'inseminacion';
    final showToro = _tipo == 'monta';
    final showDiagnostico = _tipo != 'secado';

    return AlertDialog(
      title:
          Text(widget.existing == null ? 'Nuevo evento' : 'Editar evento'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _tipos.map((t) {
                final (value, label, icon) = t;
                final selected = _tipo == value;
                return FilterChip(
                  avatar: Icon(icon, size: 14),
                  label: Text(label,
                      style: const TextStyle(fontSize: 12)),
                  selected: selected,
                  onSelected: (_) => _onTipoChanged(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            // Fecha
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.calendar_month_outlined,
                color: _showErrors && _fecha == null
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
              title: const Text('Fecha *'),
              subtitle: Text(
                _fecha != null
                    ? _fmt.format(_fecha!)
                    : 'Toca para seleccionar',
                style: _showErrors && _fecha == null
                    ? TextStyle(
                        color: Theme.of(context).colorScheme.error)
                    : null,
              ),
              onTap: _pickFecha,
            ),

            // Fecha probable parto
            if (showFechaPP)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.child_care_outlined),
                title: const Text('Parto estimado'),
                subtitle: Text(
                  _fechaProbableParto != null
                      ? _fmt.format(_fechaProbableParto!)
                      : 'Auto (+283 días)',
                ),
                trailing: _fechaProbableParto != null
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => setState(() {
                          _fechaProbableParto = null;
                          _fechaPpManual = false;
                        }),
                      )
                    : null,
                onTap: _pickFechaPP,
              ),

            // Semental picker
            if (showToro) ...[
              const SizedBox(height: 4),
              torosAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (toros) => toros.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Sin sementales registrados',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.outline,
                              fontSize: 12),
                        ),
                      )
                    : DropdownButtonFormField<int?>(
                        value: _toroId,
                        decoration: const InputDecoration(
                          labelText: 'Semental (opcional)',
                          prefixIcon: Icon(Icons.male_outlined),
                        ),
                        items: [
                          const DropdownMenuItem<int?>(
                              value: null,
                              child: Text('Sin semental')),
                          ...toros.map((t) => DropdownMenuItem<int?>(
                              value: t.id,
                              child: Text(getToroLabel(t.id)))),
                        ],
                        onChanged: (v) =>
                            setState(() => _toroId = v),
                      ),
              ),
            ],

            // Diagnóstico / Notas
            if (showDiagnostico) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _diagnosticoCtrl,
                decoration: InputDecoration(
                  labelText: _tipo == 'diagnostico_gestacion'
                      ? 'Diagnóstico / Resultado'
                      : _tipo == 'inseminacion'
                          ? 'Semen / Notas'
                          : 'Notas',
                  hintText: 'Opcional',
                  prefixIcon: const Icon(Icons.notes_outlined),
                ),
                maxLines: 2,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: isLoading ? null : () => Navigator.pop(context),
            child: const Text('Cancelar')),
        FilledButton(
          onPressed: (isLoading || _fecha == null) ? null : _save,
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(widget.existing == null ? 'Registrar' : 'Guardar'),
        ),
      ],
    );
  }
}

// ─── Photo viewer ─────────────────────────────────────────────────────────────

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
                  icon: const Icon(Icons.close,
                      color: Colors.white, size: 28),
                  style:
                      IconButton.styleFrom(backgroundColor: Colors.black45),
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
                      color: _current == i ? Colors.white : Colors.white38,
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
