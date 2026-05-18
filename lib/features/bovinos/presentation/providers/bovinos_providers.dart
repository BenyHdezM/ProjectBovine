import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/bovino_with_dueno.dart';
import '../../../../core/providers/database_provider.dart';

// ─── Listas reactivas ────────────────────────────────────────────────────────

final bovinosListProvider = StreamProvider<List<BovinoWithDueno>>((ref) {
  return ref.watch(appDatabaseProvider).bovinosDao.watchBovinosWithDueno();
});

final duenosListProvider = StreamProvider<List<Dueno>>((ref) {
  return ref.watch(appDatabaseProvider).duenosDao.watchAllDuenos();
});

final razasListProvider = StreamProvider<List<Raza>>((ref) {
  return ref.watch(appDatabaseProvider).bovinosDao.watchAllRazas();
});

final lotesListProvider = StreamProvider<List<Lote>>((ref) {
  return ref.watch(appDatabaseProvider).bovinosDao.watchAllLotes();
});

// ─── Formulario de bovino ────────────────────────────────────────────────────

class BovinoFormNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String?> save({
    required BovinosCompanion bovino,
    int? duenoId,
    int? editId,
    DateTime? fechaVenta,
  }) async {
    state = const AsyncLoading();

    try {
      final dao = ref.read(appDatabaseProvider).bovinosDao;
      // Validar unicidad de arete_id
      final existente = await dao.findByAreteId(bovino.areteId.value);
      if (existente != null && existente.id != editId) {
        state = const AsyncData(null);
        return 'El arete "${bovino.areteId.value}" ya está registrado.';
      }

      // Validar unicidad de nombre (si se proporcionó)
      final nombreVal = bovino.nombre.present ? bovino.nombre.value : null;
      if (nombreVal != null && nombreVal.isNotEmpty) {
        final existenteNombre = await dao.findByNombre(nombreVal);
        if (existenteNombre != null && existenteNombre.id != editId) {
          state = const AsyncData(null);
          return 'El nombre "$nombreVal" ya está registrado.';
        }
      }

      int bovinoId;
      if (editId == null) {
        bovinoId = await dao.insertBovinoWithDueno(bovino, duenoId: duenoId);
      } else {
        bovinoId = editId;
        final withId = bovino.copyWith(id: Value(editId));
        await dao.updateBovino(withId);
        if (duenoId != null) {
          await dao.transferirDueno(editId, duenoId);
        }
      }

      // Si estado = vendido, guardar en tabla Ventas
      if (bovino.estado.value == 'vendido' && fechaVenta != null) {
        await dao.upsertVenta(bovinoId, fechaVenta);
      }

      state = const AsyncData(null);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return e.toString();
    }
  }
}

final bovinoFormProvider =
    AsyncNotifierProvider<BovinoFormNotifier, void>(BovinoFormNotifier.new);
