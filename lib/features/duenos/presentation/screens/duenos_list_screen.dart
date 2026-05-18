import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../bovinos/presentation/providers/bovinos_providers.dart';

class DuenosListScreen extends ConsumerStatefulWidget {
  const DuenosListScreen({super.key});

  @override
  ConsumerState<DuenosListScreen> createState() => _DuenosListScreenState();
}

class _DuenosListScreenState extends ConsumerState<DuenosListScreen> {
  Future<void> _deleteDueno(Dueno dueno) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Dueño'),
        content: Text('¿Borrar a "${dueno.nombre}"? Se eliminarán también las relaciones con los bovinos.'),
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
        await db.duenosDao.deleteDuenoClean(dueno.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Borrado "${dueno.nombre}"')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final duenosAsync = ref.watch(duenosListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dueños')),
      body: duenosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (duenos) => duenos.isEmpty
            ? const Center(child: Text('No hay dueños registrados.'))
            : ListView.builder(
                itemCount: duenos.length,
                itemBuilder: (context, index) {
                  final d = duenos[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(d.nombre),
                    subtitle: d.telefono != null ? Text(d.telefono!) : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: 'Editar',
                          onPressed: () => context.push('/duenos/${d.id}', extra: d),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Eliminar',
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => _deleteDueno(d),
                        ),
                      ],
                    ),
                    onTap: () => context.push('/duenos/${d.id}', extra: d),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/duenos/new'),
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Nuevo Dueño'),
      ),
    );
  }
}
