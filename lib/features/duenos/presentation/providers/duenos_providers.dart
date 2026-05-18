import 'dart:async';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';

class DuenoFormNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String?> save({
    required DuenosCompanion dueno,
    int? editId,
  }) async {
    state = const AsyncLoading();
    try {
      final dao = ref.read(appDatabaseProvider).duenosDao;
      if (editId == null) {
        await dao.insertDueno(dueno);
      } else {
        await dao.updateDueno(dueno.copyWith(id: Value(editId)));
      }
      state = const AsyncData(null);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return e.toString();
    }
  }
}

final duenoFormProvider =
    AsyncNotifierProvider<DuenoFormNotifier, void>(DuenoFormNotifier.new);
