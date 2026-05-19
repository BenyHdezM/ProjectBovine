import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/database/models/bovino_with_dueno.dart';
import '../../../../core/database/seeds/seed_test_data.dart';
import '../providers/bovinos_providers.dart';

enum _EdadFiltroTipo { rango, mayorQue, menorQue }

enum _SortCampo { arete, nombre, dueno, edad }

class BovinosListScreen extends ConsumerStatefulWidget {
  const BovinosListScreen({super.key});

  @override
  ConsumerState<BovinosListScreen> createState() => _BovinosListScreenState();
}

class _BovinosListScreenState extends ConsumerState<BovinosListScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String? _estadoFilter;
  String? _sexoFilter;
  _EdadFiltroTipo? _edadFiltroTipo;
  RangeValues _edadRango = const RangeValues(0, 20);
  double _edadValor = 5;
  _SortCampo? _sortCampo;
  bool _sortAscending = true;

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
    var lista = todos.where((item) {
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

      if (_edadFiltroTipo != null) {
        final edad = _calcularEdad(b.fechaNacimiento);
        if (edad == null) return false;
        switch (_edadFiltroTipo!) {
          case _EdadFiltroTipo.rango:
            if (edad < _edadRango.start.round() ||
                edad > _edadRango.end.round()) return false;
          case _EdadFiltroTipo.mayorQue:
            if (edad <= _edadValor.round()) return false;
          case _EdadFiltroTipo.menorQue:
            if (edad >= _edadValor.round()) return false;
        }
      }

      return true;
    }).toList();

    if (_sortCampo != null) {
      lista.sort((a, b) {
        final cmp = switch (_sortCampo!) {
          _SortCampo.arete =>
            a.bovino.areteId.compareTo(b.bovino.areteId),
          _SortCampo.nombre =>
            (a.bovino.nombre ?? '').compareTo(b.bovino.nombre ?? ''),
          _SortCampo.dueno =>
            (a.dueno?.nombre ?? '').compareTo(b.dueno?.nombre ?? ''),
          _SortCampo.edad => (_calcularEdad(a.bovino.fechaNacimiento) ?? -1)
              .compareTo(_calcularEdad(b.bovino.fechaNacimiento) ?? -1),
        };
        return _sortAscending ? cmp : -cmp;
      });
    }

    return lista;
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
                edadFiltroTipo: _edadFiltroTipo,
                edadRango: _edadRango,
                edadValor: _edadValor,
                sortCampo: _sortCampo,
                sortAscending: _sortAscending,
                total: todos.length,
                filtrados: bovinos.length,
                onSearch: (v) => setState(() => _searchQuery = v.trim()),
                onEstado: (v) => setState(() => _estadoFilter = v),
                onSexo: (v) => setState(() => _sexoFilter = v),
                onEdadFiltroTipo: (v) => setState(() => _edadFiltroTipo = v),
                onEdadRango: (v) => setState(() => _edadRango = v),
                onEdadValor: (v) => setState(() => _edadValor = v),
                onSortCampo: (v) => setState(() => _sortCampo = v),
                onSortAscending: (v) => setState(() => _sortAscending = v),
              ),
              Expanded(
                child: bovinos.isEmpty
                    ? _EmptyState(hayFiltros: _searchQuery.isNotEmpty ||
                        _estadoFilter != null || _sexoFilter != null ||
                        _edadFiltroTipo != null || _sortCampo != null)
                    : _AdaptiveList(
                        bovinos: bovinos,
                        onDelete: _deleteBovino,
                        sortCampo: _sortCampo,
                        sortAscending: _sortAscending,
                        onSort: (col, asc) => setState(() {
                          _sortCampo = _colIndexToSortCampo(col);
                          _sortAscending = asc;
                        }),
                        edadFiltroTipo: _edadFiltroTipo,
                        edadRango: _edadRango,
                        edadValor: _edadValor,
                        onEdadFiltroTipo: (v) =>
                            setState(() => _edadFiltroTipo = v),
                        onEdadRango: (v) => setState(() => _edadRango = v),
                        onEdadValor: (v) => setState(() => _edadValor = v),
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
  final _EdadFiltroTipo? edadFiltroTipo;
  final RangeValues edadRango;
  final double edadValor;
  final _SortCampo? sortCampo;
  final bool sortAscending;
  final int total;
  final int filtrados;
  final ValueChanged<String> onSearch;
  final ValueChanged<String?> onEstado;
  final ValueChanged<String?> onSexo;
  final ValueChanged<_EdadFiltroTipo?> onEdadFiltroTipo;
  final ValueChanged<RangeValues> onEdadRango;
  final ValueChanged<double> onEdadValor;
  final ValueChanged<_SortCampo?> onSortCampo;
  final ValueChanged<bool> onSortAscending;

  const _Filtros({
    required this.searchCtrl,
    required this.estadoFilter,
    required this.sexoFilter,
    required this.edadFiltroTipo,
    required this.edadRango,
    required this.edadValor,
    required this.sortCampo,
    required this.sortAscending,
    required this.total,
    required this.filtrados,
    required this.onSearch,
    required this.onEstado,
    required this.onSexo,
    required this.onEdadFiltroTipo,
    required this.onEdadRango,
    required this.onEdadValor,
    required this.onSortCampo,
    required this.onSortAscending,
  });

  @override
  Widget build(BuildContext context) {
    final hayFiltro = estadoFilter != null || sexoFilter != null ||
        searchCtrl.text.isNotEmpty || edadFiltroTipo != null;

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

          // ── Chips de filtros ───────────────────────────────────────────────
          Row(
            children: [
              Text(
                'Filtros:',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FiltroChip(
                        label: switch (estadoFilter) {
                          'activo' => 'Activo',
                          'vendido' => 'Vendido',
                          'muerto' => 'Muerto',
                          _ => 'Estado',
                        },
                        selected: estadoFilter != null,
                        color: switch (estadoFilter) {
                          'activo' => Colors.green,
                          'vendido' => Colors.orange,
                          'muerto' => Colors.grey,
                          _ => null,
                        },
                        onTap: () => _mostrarFiltroEstado(context,
                            estado: estadoFilter, onEstado: onEstado),
                      ),
                      _FiltroChip(
                        label: switch (sexoFilter) {
                          'H' => 'Hembra',
                          'M' => 'Macho',
                          _ => 'Sexo',
                        },
                        selected: sexoFilter != null,
                        color: Colors.purple,
                        onTap: () => _mostrarFiltroSexo(context,
                            sexo: sexoFilter, onSexo: onSexo),
                      ),
                      _FiltroChip(
                        label: edadFiltroTipo == null
                            ? 'Edad'
                            : switch (edadFiltroTipo!) {
                                _EdadFiltroTipo.rango =>
                                  '${edadRango.start.round()}–${edadRango.end.round()} a',
                                _EdadFiltroTipo.mayorQue =>
                                  '> ${edadValor.round()} a',
                                _EdadFiltroTipo.menorQue =>
                                  '< ${edadValor.round()} a',
                              },
                        selected: edadFiltroTipo != null,
                        color: Colors.teal,
                        onTap: () => _mostrarFiltroEdad(
                          context,
                          tipo: edadFiltroTipo,
                          rango: edadRango,
                          valor: edadValor,
                          onTipo: onEdadFiltroTipo,
                          onRango: onEdadRango,
                          onValor: onEdadValor,
                        ),
                      ),
                      _FiltroChip(
                        label: sortCampo == null
                            ? 'Ordenar'
                            : '${switch (sortCampo!) {
                                _SortCampo.arete => 'Arete',
                                _SortCampo.nombre => 'Nombre',
                                _SortCampo.dueno => 'Dueño',
                                _SortCampo.edad => 'Edad',
                              }} ${sortAscending ? '↑' : '↓'}',
                        selected: sortCampo != null,
                        color: Colors.indigo,
                        onTap: () => _mostrarOrdenarPor(
                          context,
                          campo: sortCampo,
                          ascending: sortAscending,
                          onCampo: onSortCampo,
                          onAscending: onSortAscending,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // ── Contador ───────────────────────────────────────────────────────
          Text(
            hayFiltro ? '$filtrados de $total bovinos' : '$total bovinos',
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
      padding: const EdgeInsets.only(right: 4),
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
  final _SortCampo? sortCampo;
  final bool sortAscending;
  final DataColumnSortCallback onSort;
  final _EdadFiltroTipo? edadFiltroTipo;
  final RangeValues edadRango;
  final double edadValor;
  final ValueChanged<_EdadFiltroTipo?> onEdadFiltroTipo;
  final ValueChanged<RangeValues> onEdadRango;
  final ValueChanged<double> onEdadValor;

  const _AdaptiveList({
    required this.bovinos,
    required this.onDelete,
    required this.sortCampo,
    required this.sortAscending,
    required this.onSort,
    required this.edadFiltroTipo,
    required this.edadRango,
    required this.edadValor,
    required this.onEdadFiltroTipo,
    required this.onEdadRango,
    required this.onEdadValor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 640) {
          return _BovinosDataTable(
            bovinos: bovinos,
            onDelete: onDelete,
            sortCampo: sortCampo,
            sortAscending: sortAscending,
            onSort: onSort,
            edadFiltroTipo: edadFiltroTipo,
            edadRango: edadRango,
            edadValor: edadValor,
            onEdadFiltroTipo: onEdadFiltroTipo,
            onEdadRango: onEdadRango,
            onEdadValor: onEdadValor,
          );
        }
        return _BovinosListView(bovinos: bovinos, onDelete: onDelete);
      },
    );
  }
}

// ─── Utilidades ──────────────────────────────────────────────────────────────

int? _sortCampoToColIndex(_SortCampo? campo) => switch (campo) {
  _SortCampo.arete => 0,
  _SortCampo.nombre => 1,
  _SortCampo.dueno => 2,
  _SortCampo.edad => 4,
  null => null,
};

_SortCampo? _colIndexToSortCampo(int index) => switch (index) {
  0 => _SortCampo.arete,
  1 => _SortCampo.nombre,
  2 => _SortCampo.dueno,
  4 => _SortCampo.edad,
  _ => null,
};

void _mostrarOrdenarPor(
  BuildContext context, {
  required _SortCampo? campo,
  required bool ascending,
  required ValueChanged<_SortCampo?> onCampo,
  required ValueChanged<bool> onAscending,
}) {
  _SortCampo? localCampo = campo;
  bool localAscending = ascending;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setLocal) => AlertDialog(
        title: const Text('Ordenar por'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<_SortCampo?>(
              value: localCampo,
              decoration: const InputDecoration(
                labelText: 'Campo',
                prefixIcon: Icon(Icons.sort),
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text('Sin orden')),
                DropdownMenuItem(value: _SortCampo.arete, child: Text('Arete')),
                DropdownMenuItem(value: _SortCampo.nombre, child: Text('Nombre')),
                DropdownMenuItem(value: _SortCampo.dueno, child: Text('Dueño')),
                DropdownMenuItem(value: _SortCampo.edad, child: Text('Edad')),
              ],
              onChanged: (v) => setLocal(() => localCampo = v),
            ),
            const SizedBox(height: 20),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  label: Text('Ascendente'),
                  icon: Icon(Icons.arrow_upward, size: 16),
                ),
                ButtonSegment(
                  value: false,
                  label: Text('Descendente'),
                  icon: Icon(Icons.arrow_downward, size: 16),
                ),
              ],
              selected: {localAscending},
              onSelectionChanged: (v) =>
                  setLocal(() => localAscending = v.first),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              onCampo(null);
              Navigator.pop(ctx);
            },
            child: const Text('Limpiar'),
          ),
          FilledButton(
            onPressed: () {
              onCampo(localCampo);
              onAscending(localAscending);
              Navigator.pop(ctx);
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    ),
  );
}

void _mostrarFiltroEstado(
  BuildContext context, {
  required String? estado,
  required ValueChanged<String?> onEstado,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Filtrar por Estado'),
      content: SizedBox(
        width: 320,
        child: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ChoiceChip(
              label: const Text('Activo'),
              selected: estado == 'activo',
              onSelected: (_) { onEstado('activo'); Navigator.pop(ctx); },
            ),
            ChoiceChip(
              label: const Text('Vendido'),
              selected: estado == 'vendido',
              onSelected: (_) { onEstado('vendido'); Navigator.pop(ctx); },
            ),
            ChoiceChip(
              label: const Text('Muerto'),
              selected: estado == 'muerto',
              onSelected: (_) { onEstado('muerto'); Navigator.pop(ctx); },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () { onEstado(null); Navigator.pop(ctx); },
          child: const Text('Limpiar'),
        ),
      ],
    ),
  );
}

void _mostrarFiltroSexo(
  BuildContext context, {
  required String? sexo,
  required ValueChanged<String?> onSexo,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Filtrar por Sexo'),
      content: SizedBox(
        width: 320,
        child: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ChoiceChip(
              label: const Text('Hembra'),
              selected: sexo == 'H',
              onSelected: (_) { onSexo('H'); Navigator.pop(ctx); },
            ),
            ChoiceChip(
              label: const Text('Macho'),
              selected: sexo == 'M',
              onSelected: (_) { onSexo('M'); Navigator.pop(ctx); },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () { onSexo(null); Navigator.pop(ctx); },
          child: const Text('Limpiar'),
        ),
      ],
    ),
  );
}

void _mostrarFiltroEdad(
  BuildContext context, {
  required _EdadFiltroTipo? tipo,
  required RangeValues rango,
  required double valor,
  required ValueChanged<_EdadFiltroTipo?> onTipo,
  required ValueChanged<RangeValues> onRango,
  required ValueChanged<double> onValor,
}) {
  _EdadFiltroTipo? localTipo = tipo;
  RangeValues localRango = rango;
  double localValor = valor;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setLocal) => AlertDialog(
        title: const Text('Filtrar por Edad'),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  ChoiceChip(
                    label: const Text('Rango'),
                    selected: localTipo == _EdadFiltroTipo.rango,
                    onSelected: (_) =>
                        setLocal(() => localTipo = _EdadFiltroTipo.rango),
                  ),
                  ChoiceChip(
                    label: const Text('Mayor que'),
                    selected: localTipo == _EdadFiltroTipo.mayorQue,
                    onSelected: (_) =>
                        setLocal(() => localTipo = _EdadFiltroTipo.mayorQue),
                  ),
                  ChoiceChip(
                    label: const Text('Menor que'),
                    selected: localTipo == _EdadFiltroTipo.menorQue,
                    onSelected: (_) =>
                        setLocal(() => localTipo = _EdadFiltroTipo.menorQue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (localTipo == _EdadFiltroTipo.rango) ...[
                Text('${localRango.start.round()} – ${localRango.end.round()} años'),
                RangeSlider(
                  values: localRango,
                  min: 0,
                  max: 25,
                  divisions: 25,
                  labels: RangeLabels(
                    localRango.start.round().toString(),
                    localRango.end.round().toString(),
                  ),
                  onChanged: (v) => setLocal(() => localRango = v),
                ),
              ],
              if (localTipo == _EdadFiltroTipo.mayorQue) ...[
                Text('Mayor que ${localValor.round()} años'),
                Slider(
                  value: localValor,
                  min: 0,
                  max: 25,
                  divisions: 25,
                  label: '${localValor.round()}',
                  onChanged: (v) => setLocal(() => localValor = v),
                ),
              ],
              if (localTipo == _EdadFiltroTipo.menorQue) ...[
                Text('Menor que ${localValor.round()} años'),
                Slider(
                  value: localValor,
                  min: 0,
                  max: 25,
                  divisions: 25,
                  label: '${localValor.round()}',
                  onChanged: (v) => setLocal(() => localValor = v),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onTipo(null);
              Navigator.pop(ctx);
            },
            child: const Text('Limpiar'),
          ),
          FilledButton(
            onPressed: () {
              onTipo(localTipo);
              onRango(localRango);
              onValor(localValor);
              Navigator.pop(ctx);
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    ),
  );
}

int? _calcularEdad(DateTime? fechaNacimiento) {
  if (fechaNacimiento == null) return null;
  final hoy = DateTime.now();
  int edad = hoy.year - fechaNacimiento.year;
  if (hoy.month < fechaNacimiento.month ||
      (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
    edad--;
  }
  return edad < 0 ? 0 : edad;
}

// ─── Vista de tabla (web / tablet) ───────────────────────────────────────────

class _BovinosDataTable extends StatelessWidget {
  final List<BovinoWithDueno> bovinos;
  final void Function(BovinoWithDueno) onDelete;
  final _SortCampo? sortCampo;
  final bool sortAscending;
  final DataColumnSortCallback onSort;
  final _EdadFiltroTipo? edadFiltroTipo;
  final RangeValues edadRango;
  final double edadValor;
  final ValueChanged<_EdadFiltroTipo?> onEdadFiltroTipo;
  final ValueChanged<RangeValues> onEdadRango;
  final ValueChanged<double> onEdadValor;

  const _BovinosDataTable({
    required this.bovinos,
    required this.onDelete,
    required this.sortCampo,
    required this.sortAscending,
    required this.onSort,
    required this.edadFiltroTipo,
    required this.edadRango,
    required this.edadValor,
    required this.onEdadFiltroTipo,
    required this.onEdadRango,
    required this.onEdadValor,
  });

  void _showFiltroEdad(BuildContext context) => _mostrarFiltroEdad(
        context,
        tipo: edadFiltroTipo,
        rango: edadRango,
        valor: edadValor,
        onTipo: onEdadFiltroTipo,
        onRango: onEdadRango,
        onValor: onEdadValor,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          sortColumnIndex: _sortCampoToColIndex(sortCampo),
          sortAscending: sortAscending,
          headingRowColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          columns: [
            DataColumn(label: const Text('Arete'), onSort: onSort),
            DataColumn(label: const Text('Nombre'), onSort: onSort),
            DataColumn(label: const Text('Dueño'), onSort: onSort),
            const DataColumn(label: Text('Sexo')),
            DataColumn(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Edad'),
                  const SizedBox(width: 2),
                  GestureDetector(
                    onTap: () => _showFiltroEdad(context),
                    child: Icon(
                      edadFiltroTipo != null
                          ? Icons.filter_alt
                          : Icons.filter_alt_outlined,
                      size: 15,
                      color: edadFiltroTipo != null
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
              numeric: true,
              onSort: onSort,
            ),
            const DataColumn(label: Text('Estado')),
            const DataColumn(label: Text('Acciones')),
          ],
          rows: bovinos
              .map(
                (item) => DataRow(
                  cells: [
                    DataCell(Text(item.bovino.areteId)),
                    DataCell(Text(item.bovino.nombre ?? '—')),
                    DataCell(Text(item.dueno?.nombre ?? '—')),
                    DataCell(Text(item.bovino.sexo)),
                    DataCell(Text(
                      _calcularEdad(item.bovino.fechaNacimiento)
                              ?.toString() ??
                          '—',
                    )),
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
              if (item.dueno != null) item.dueno!.nombre,
              if (_calcularEdad(item.bovino.fechaNacimiento) != null)
                '${_calcularEdad(item.bovino.fechaNacimiento)} años',
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
