import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../bovinos/presentation/providers/bovinos_providers.dart';

class LotesListScreen extends ConsumerStatefulWidget {
  const LotesListScreen({super.key});

  @override
  ConsumerState<LotesListScreen> createState() => _LotesListScreenState();
}

class _LotesListScreenState extends ConsumerState<LotesListScreen> {
  Future<void> _deleteLote(Lote lote) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Lote'),
        content: Text(
            '¿Borrar el lote "${lote.clave}"? Los bovinos asignados quedarán sin lote.'),
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
      try {
        await ref.read(appDatabaseProvider).bovinosDao.deleteLoteClean(lote.id);
        if (mounted) {
          messenger.showSnackBar(
            SnackBar(content: Text('Lote "${lote.clave}" eliminado')),
          );
        }
      } catch (e) {
        if (mounted) {
          messenger.showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lotesAsync = ref.watch(lotesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lotes')),
      body: lotesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (lotes) => lotes.isEmpty
            ? const Center(child: Text('No hay lotes registrados.'))
            : ListView.builder(
                itemCount: lotes.length,
                itemBuilder: (context, index) {
                  final l = lotes[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(l.clave)),
                    title: Text(l.clave),
                    subtitle:
                        l.descripcion != null ? Text(l.descripcion!) : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: 'Editar',
                          onPressed: () =>
                              context.push('/lotes/${l.id}', extra: l),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Eliminar',
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => _deleteLote(l),
                        ),
                      ],
                    ),
                    onTap: () => context.push('/lotes/${l.id}', extra: l),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/lotes/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Lote'),
      ),
    );
  }
}
