import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../providers/duenos_providers.dart';

class DuenoFormScreen extends ConsumerStatefulWidget {
  final Dueno? dueno;

  const DuenoFormScreen({super.key, this.dueno});

  @override
  ConsumerState<DuenoFormScreen> createState() => _DuenoFormScreenState();
}

class _DuenoFormScreenState extends ConsumerState<DuenoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _telefonoCtrl;

  bool get _esEdicion => widget.dueno != null;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.dueno?.nombre ?? '');
    _telefonoCtrl =
        TextEditingController(text: widget.dueno?.telefono ?? '');
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _telefonoCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final companion = DuenosCompanion(
      nombre: Value(_nombreCtrl.text.trim()),
      telefono: Value(
        _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
      ),
    );

    final error = await ref
        .read(duenoFormProvider.notifier)
        .save(dueno: companion, editId: widget.dueno?.id);

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
    final isLoading = ref.watch(duenoFormProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Dueño' : 'Nuevo Dueño'),
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
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre *',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefonoCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: isLoading ? null : _submit,
                  icon: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(isLoading
                      ? 'Guardando…'
                      : _esEdicion
                          ? 'Guardar cambios'
                          : 'Registrar Dueño'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
