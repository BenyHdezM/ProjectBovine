import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../bovinos/presentation/providers/bovinos_providers.dart';

class DuenosListScreen extends ConsumerWidget {
  const DuenosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
