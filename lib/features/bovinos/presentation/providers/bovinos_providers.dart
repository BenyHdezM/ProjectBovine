import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
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

final fotosByBovinoProvider =
    StreamProvider.family<List<Foto>, int>((ref, bovinoId) {
  return ref.watch(appDatabaseProvider).fotosDao.watchFotosByBovinoId(bovinoId);
});

final partosByBovinoProvider =
    StreamProvider.family<List<Parto>, int>((ref, bovinoId) {
  return ref
      .watch(appDatabaseProvider)
      .bovinosDao
      .watchPartosByBovinoId(bovinoId);
});

// ─── Formulario de bovino ────────────────────────────────────────────────────

class BovinoFormNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<({int? madreId, int? padreId})?> getProgenie(int bovinoId) async {
    final p = await ref
        .read(appDatabaseProvider)
        .bovinosDao
        .getProgenieByBovinoId(bovinoId);
    if (p == null) return null;
    return (madreId: p.bovinaMadreId, padreId: p.bovinoPadreId);
  }

  Future<String?> save({
    required BovinosCompanion bovino,
    int? duenoId,
    int? editId,
    DateTime? fechaVenta,
    int? madreId,
    int? padreId,
    List<File> newPhotoFiles = const [],
    List<int> deletedPhotoIds = const [],
  }) async {
    state = const AsyncLoading();

    try {
      final dao = ref.read(appDatabaseProvider).bovinosDao;
      final fotosDao = ref.read(appDatabaseProvider).fotosDao;

      // Validar unicidad de arete_id (solo si se proporcionó)
      if (bovino.areteId.value.isNotEmpty) {
        final existente = await dao.findByAreteId(bovino.areteId.value);
        if (existente != null && existente.id != editId) {
          state = const AsyncData(null);
          return 'El arete "${bovino.areteId.value}" ya está registrado.';
        }
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

      // Progenie
      int? oldMadreId;
      if (editId != null) {
        final existing = await dao.getProgenieByBovinoId(editId);
        oldMadreId = existing?.bovinaMadreId;
      }
      if (editId != null || madreId != null || padreId != null) {
        await dao.upsertProgenie(bovinoId, madreId: madreId, padreId: padreId);
      }

      // Auto-parto cuando se asigna o cambia la madre y hay fecha de nacimiento
      if (madreId != null &&
          madreId != oldMadreId &&
          bovino.fechaNacimiento.value != null) {
        await dao.insertParto(PartosCompanion(
          bovinoId: Value(madreId),
          fechaParto: Value(bovino.fechaNacimiento.value!),
        ));
      }

      // Eliminar fotos marcadas para borrado
      for (final photoId in deletedPhotoIds) {
        final foto = await fotosDao.getFotoById(photoId);
        await fotosDao.deleteFoto(photoId);
        if (foto != null) {
          try {
            final file = File(foto.rutaFoto);
            if (await file.exists()) await file.delete();
          } catch (_) {}
        }
      }

      // Guardar fotos nuevas
      if (newPhotoFiles.isNotEmpty) {
        final appDir = await getApplicationDocumentsDirectory();
        final bovDir = Directory('${appDir.path}/bovinos/$bovinoId');
        await bovDir.create(recursive: true);
        for (final file in newPhotoFiles) {
          final ext = file.path.split('.').last;
          final newPath =
              '${bovDir.path}/${DateTime.now().microsecondsSinceEpoch}.$ext';
          await file.copy(newPath);
          await fotosDao.insertFoto(FotosCompanion(
            bovinoId: Value(bovinoId),
            rutaFoto: Value(newPath),
          ));
        }
      }

      state = const AsyncData(null);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return e.toString();
    }
  }

  Future<String?> deleteBovino(int id) async {
    state = const AsyncLoading();
    try {
      final db = ref.read(appDatabaseProvider);
      final fotos = await db.fotosDao.getFotosByBovinoId(id);

      // Borrar archivos físicos
      for (final foto in fotos) {
        try {
          final file = File(foto.rutaFoto);
          if (await file.exists()) await file.delete();
        } catch (_) {}
      }

      // Borrar carpeta del bovino si quedó vacía u orfana
      final appDir = await getApplicationDocumentsDirectory();
      final bovDir = Directory('${appDir.path}/bovinos/$id');
      if (await bovDir.exists()) {
        try { await bovDir.delete(recursive: true); } catch (_) {}
      }

      await db.bovinosDao.deleteBovinoWithChildren(id);

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

// ─── Formulario de parto ─────────────────────────────────────────────────────

class PartoFormNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String?> saveParto({
    required int bovinoId,
    required DateTime fechaParto,
    String? notas,
    int? editId,
  }) async {
    state = const AsyncLoading();
    try {
      final dao = ref.read(appDatabaseProvider).bovinosDao;
      if (editId == null) {
        await dao.insertParto(PartosCompanion(
          bovinoId: Value(bovinoId),
          fechaParto: Value(fechaParto),
          notas: Value(notas),
        ));
      } else {
        await dao.updateParto(PartosCompanion(
          id: Value(editId),
          bovinoId: Value(bovinoId),
          fechaParto: Value(fechaParto),
          notas: Value(notas),
        ));
      }
      state = const AsyncData(null);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return e.toString();
    }
  }

  Future<String?> deleteParto(int id) async {
    state = const AsyncLoading();
    try {
      await ref.read(appDatabaseProvider).bovinosDao.deleteParto(id);
      state = const AsyncData(null);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return e.toString();
    }
  }
}

final partoFormProvider =
    AsyncNotifierProvider<PartoFormNotifier, void>(PartoFormNotifier.new);
