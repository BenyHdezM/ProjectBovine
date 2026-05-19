import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';
import '../providers/lotes_providers.dart';

class LoteFormScreen extends ConsumerStatefulWidget {
  final Lote? lote;

  const LoteFormScreen({super.key, this.lote});

  @override
  ConsumerState<LoteFormScreen> createState() => _LoteFormScreenState();
}

class _LoteFormScreenState extends ConsumerState<LoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _claveCtrl;
  late final TextEditingController _descripcionCtrl;

  bool get _esEdicion => widget.lote != null;

  @override
  void initState() {
    super.initState();
    _claveCtrl = TextEditingController(text: widget.lote?.clave ?? '');
    _descripcionCtrl =
        TextEditingController(text: widget.lote?.descripcion ?? '');
  }

  @override
  void dispose() {
    _claveCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _deleteLote(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Lote'),
        content: const Text(
            '¿Estás seguro de eliminar este lote? Los bovinos asignados quedarán sin lote.'),
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
        await ref.read(appDatabaseProvider).bovinosDao.deleteLoteClean(id);
        if (mounted) {
          context.pop();
          messenger.showSnackBar(
              const SnackBar(content: Text('Lote eliminado')));
        }
      } catch (e) {
        if (mounted) {
          messenger.showSnackBar(
              SnackBar(content: Text('Error al eliminar: $e')));
        }
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final companion = LotesCompanion(
      clave: Value(_claveCtrl.text.trim().toUpperCase()),
      descripcion: Value(
        _descripcionCtrl.text.trim().isEmpty
            ? null
            : _descripcionCtrl.text.trim(),
      ),
    );

    final error = await ref
        .read(loteFormProvider.notifier)
        .save(lote: companion, editId: widget.lote?.id);

    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loteFormProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Lote' : 'Nuevo Lote'),
        actions: _esEdicion
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Eliminar',
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => _deleteLote(widget.lote!.id),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _claveCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Clave *',
                    prefixIcon: Icon(Icons.label_outline),
                    helperText: 'Código corto del lote (ej. R, O, H, E)',
                  ),
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 10,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Campo requerido'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descripcionCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    prefixIcon: Icon(Icons.description_outlined),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: isLoading ? null : _submit,
                        icon: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(isLoading
                            ? 'Guardando…'
                            : _esEdicion
                                ? 'Guardar cambios'
                                : 'Registrar Lote'),
                      ),
                    ),
                    if (_esEdicion) ...[
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => _deleteLote(widget.lote!.id),
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
  }
}
