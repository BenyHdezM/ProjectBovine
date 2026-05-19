import 'dart:async';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';

class LoteFormNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String?> save({
    required LotesCompanion lote,
    int? editId,
  }) async {
    state = const AsyncLoading();
    try {
      final dao = ref.read(appDatabaseProvider).bovinosDao;
      if (editId == null) {
        await dao.insertLote(lote);
      } else {
        await dao.updateLote(lote.copyWith(id: Value(editId)));
      }
      state = const AsyncData(null);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return e.toString();
    }
  }
}

final loteFormProvider =
    AsyncNotifierProvider<LoteFormNotifier, void>(LoteFormNotifier.new);
