import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/database/models/bovino_with_dueno.dart';
import '../../../../core/database/seeds/seed_test_data.dart';
import '../providers/bovinos_providers.dart';

class BovinosListScreen extends ConsumerStatefulWidget {
  const BovinosListScreen({super.key});

  @override
  ConsumerState<BovinosListScreen> createState() => _BovinosListScreenState();
}

class _BovinosListScreenState extends ConsumerState<BovinosListScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String? _estadoFilter; // null = todos
  String? _sexoFilter;   // null = todos

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _deleteBovino(BovinoWithDueno item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Bovino'),
        content: Text(
            '¿Borrar "${item.bovino.areteId}"${item.bovino.nombre != null ? ' (${item.bovino.nombre})' : ''}? Esta acción eliminará también todas las vacunas, tratamientos y registros asociados.'),
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
      final messenger = ScaffoldMessenger.of(context);
      final error = await ref
          .read(bovinoFormProvider.notifier)
          .deleteBovino(item.bovino.id);
      if (mounted) {
        messenger.showSnackBar(
          error != null
              ? SnackBar(content: Text('Error al eliminar: $error'))
              : SnackBar(content: Text('Borrado "${item.bovino.areteId}"')),
        );
      }
    }
  }

  List<BovinoWithDueno> _filtrar(List<BovinoWithDueno> todos) {
    return todos.where((item) {
      final b = item.bovino;

      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final ok = b.areteId.toLowerCase().contains(q) ||
            (b.nombre?.toLowerCase().contains(q) ?? false) ||
            (item.dueno?.nombre.toLowerCase().contains(q) ?? false);
        if (!ok) return false;
      }

      if (_estadoFilter != null && b.estado != _estadoFilter) return false;
      if (_sexoFilter != null && b.sexo != _sexoFilter) return false;

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bovinosAsync = ref.watch(bovinosListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Inventario Bovino'),
            SizedBox(width: 6),
            Text('🐄', style: TextStyle(fontSize: 22)),
          ],
        ),
        actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.science_outlined),
              tooltip: 'Cargar datos de prueba',
              onPressed: () async {
                final db = ref.read(appDatabaseProvider);
                await seedTestData(db);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos de prueba cargados ✓')),
                  );
                }
              },
            ),
          IconButton(
            icon: const Icon(Icons.category_outlined),
            tooltip: 'Lotes',
            onPressed: () => context.push('/lotes'),
          ),
          IconButton(
            icon: const Icon(Icons.people_outline),
            tooltip: 'Dueños',
            onPressed: () => context.push('/duenos'),
          ),
        ],
      ),
      body: bovinosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (todos) {
          final bovinos = _filtrar(todos);
          return Column(
            children: [
              _Filtros(
                searchCtrl: _searchCtrl,
                estadoFilter: _estadoFilter,
                sexoFilter: _sexoFilter,
                total: todos.length,
                filtrados: bovinos.length,
                onSearch: (v) => setState(() => _searchQuery = v.trim()),
                onEstado: (v) => setState(() => _estadoFilter = v),
                onSexo: (v) => setState(() => _sexoFilter = v),
              ),
              Expanded(
                child: bovinos.isEmpty
                    ? _EmptyState(hayFiltros: _searchQuery.isNotEmpty ||
                        _estadoFilter != null || _sexoFilter != null)
                    : _AdaptiveList(
                        bovinos: bovinos,
                        onDelete: _deleteBovino,
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/bovinos/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Bovino'),
      ),
    );
  }
}

// ─── Panel de filtros ─────────────────────────────────────────────────────────

class _Filtros extends StatelessWidget {
  final TextEditingController searchCtrl;
  final String? estadoFilter;
  final String? sexoFilter;
  final int total;
  final int filtrados;
  final ValueChanged<String> onSearch;
  final ValueChanged<String?> onEstado;
  final ValueChanged<String?> onSexo;

  const _Filtros({
    required this.searchCtrl,
    required this.estadoFilter,
    required this.sexoFilter,
    required this.total,
    required this.filtrados,
    required this.onSearch,
    required this.onEstado,
    required this.onSexo,
  });

  @override
  Widget build(BuildContext context) {
    final hayFiltro = estadoFilter != null || sexoFilter != null ||
        searchCtrl.text.isNotEmpty;

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Barra de búsqueda ──────────────────────────────────────────────
          TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              hintText: 'Buscar por arete, nombre o dueño…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchCtrl.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchCtrl.clear();
                        onSearch('');
                      },
                    )
                  : null,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
            onChanged: onSearch,
          ),
          const SizedBox(height: 8),

          // ── Chips de estado ────────────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FiltroChip(
                  label: 'Todos',
                  selected: estadoFilter == null,
                  onTap: () => onEstado(null),
                ),
                _FiltroChip(
                  label: 'Activo',
                  selected: estadoFilter == 'activo',
                  color: Colors.green,
                  onTap: () =>
                      onEstado(estadoFilter == 'activo' ? null : 'activo'),
                ),
                _FiltroChip(
                  label: 'Vendido',
                  selected: estadoFilter == 'vendido',
                  color: Colors.orange,
                  onTap: () =>
                      onEstado(estadoFilter == 'vendido' ? null : 'vendido'),
                ),
                _FiltroChip(
                  label: 'Muerto',
                  selected: estadoFilter == 'muerto',
                  color: Colors.grey,
                  onTap: () =>
                      onEstado(estadoFilter == 'muerto' ? null : 'muerto'),
                ),
                const SizedBox(width: 12),
                const VerticalDivider(width: 1, indent: 4, endIndent: 4),
                const SizedBox(width: 12),
                _FiltroChip(
                  label: 'Hembra',
                  selected: sexoFilter == 'H',
                  color: Colors.pink,
                  onTap: () => onSexo(sexoFilter == 'H' ? null : 'H'),
                ),
                _FiltroChip(
                  label: 'Macho',
                  selected: sexoFilter == 'M',
                  color: Colors.blue,
                  onTap: () => onSexo(sexoFilter == 'M' ? null : 'M'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // ── Contador ───────────────────────────────────────────────────────
          Text(
            hayFiltro
                ? '$filtrados de $total bovinos'
                : '$total bovinos',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

class _FiltroChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FiltroChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: c.withValues(alpha: 0.2),
        checkmarkColor: c,
        labelStyle: TextStyle(
          color: selected ? c : null,
          fontWeight: selected ? FontWeight.w600 : null,
        ),
        side: selected ? BorderSide(color: c) : null,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

// ─── Estado vacío ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final bool hayFiltros;
  const _EmptyState({required this.hayFiltros});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(hayFiltros ? Icons.search_off : Icons.set_meal_outlined,
              size: 72, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            hayFiltros
                ? 'Sin resultados para ese filtro'
                : 'Sin bovinos registrados',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (!hayFiltros) ...[
            const SizedBox(height: 8),
            const Text('Toca el botón + para agregar el primero.'),
          ],
        ],
      ),
    );
  }
}

// ─── Lista adaptiva ─────────────────────────────────────────────────────────

class _AdaptiveList extends StatelessWidget {
  final List<BovinoWithDueno> bovinos;
  final void Function(BovinoWithDueno) onDelete;
  const _AdaptiveList({required this.bovinos, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 640) {
          return _BovinosDataTable(bovinos: bovinos, onDelete: onDelete);
        }
        return _BovinosListView(bovinos: bovinos, onDelete: onDelete);
      },
    );
  }
}

// ─── Vista de tabla (web / tablet) ───────────────────────────────────────────

class _BovinosDataTable extends StatelessWidget {
  final List<BovinoWithDueno> bovinos;
  final void Function(BovinoWithDueno) onDelete;
  const _BovinosDataTable({required this.bovinos, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          columns: const [
            DataColumn(label: Text('Arete')),
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Dueño')),
            DataColumn(label: Text('Sexo')),
            DataColumn(label: Text('Estado')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: bovinos
              .map(
                (item) => DataRow(
                  cells: [
                    DataCell(Text(item.bovino.areteId)),
                    DataCell(Text(item.bovino.nombre ?? '—')),
                    DataCell(Text(item.dueno?.nombre ?? '—')),
                    DataCell(Text(item.bovino.sexo)),
                    DataCell(_EstadoChip(estado: item.bovino.estado)),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: 'Editar',
                          onPressed: () => context.push(
                            '/bovinos/${item.bovino.id}',
                            extra: item.bovino,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Eliminar',
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => onDelete(item),
                        ),
                      ],
                    )),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ─── Vista de lista (móvil) ───────────────────────────────────────────────────

class _BovinosListView extends StatelessWidget {
  final List<BovinoWithDueno> bovinos;
  final void Function(BovinoWithDueno) onDelete;
  const _BovinosListView({required this.bovinos, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: bovinos.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = bovinos[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: item.bovino.sexo == 'M'
                ? Colors.blue.shade100
                : Colors.pink.shade100,
            child: Text(
              item.bovino.sexo,
              style: TextStyle(
                color: item.bovino.sexo == 'M'
                    ? Colors.blue.shade800
                    : Colors.pink.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(item.bovino.areteId,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(
            [
              if (item.bovino.nombre != null) item.bovino.nombre!,
              if (item.dueno != null) 'Dueño: ${item.dueno!.nombre}',
            ].join(' · '),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EstadoChip(estado: item.bovino.estado),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Editar',
                onPressed: () => context.push(
                  '/bovinos/${item.bovino.id}',
                  extra: item.bovino,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Eliminar',
                color: Theme.of(context).colorScheme.error,
                onPressed: () => onDelete(item),
              ),
            ],
          ),
          onTap: () => context.push(
            '/bovinos/${item.bovino.id}',
            extra: item.bovino,
          ),
        );
      },
    );
  }
}

class _EstadoChip extends StatelessWidget {
  final String estado;
  const _EstadoChip({required this.estado});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (estado) {
      'vendido' => (Colors.orange, 'Vendido'),
      'muerto'  => (Colors.grey, 'Muerto'),
      _         => (Colors.green, 'Activo'),
    };
    return Chip(
      label: Text(label,
          style: const TextStyle(fontSize: 11, color: Colors.white)),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
