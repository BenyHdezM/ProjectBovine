import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/duenos_table.dart';
import '../tables/pertenencia_table.dart';

part 'duenos_dao.g.dart';

@DriftAccessor(tables: [Duenos, Pertenencia])
class DuenosDao extends DatabaseAccessor<AppDatabase>
    with _$DuenosDaoMixin {
  DuenosDao(super.db);

  Stream<List<Dueno>> watchAllDuenos() =>
      (select(db.duenos)
            ..orderBy([(d) => OrderingTerm(expression: d.nombre)]))
          .watch();

  Future<List<Dueno>> getAllDuenos() =>
      (select(db.duenos)
            ..orderBy([(d) => OrderingTerm(expression: d.nombre)]))
          .get();

  Future<int> insertDueno(DuenosCompanion entry) =>
      into(db.duenos).insert(entry);

  Future<bool> updateDueno(DuenosCompanion entry) =>
      update(db.duenos).replace(entry);

  Future<int> deleteDueno(int id) =>
      (delete(db.duenos)..where((d) => d.id.equals(id))).go();
}
