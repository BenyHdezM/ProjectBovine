import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/bovinos_table.dart';
import '../tables/fotos_table.dart';

part 'fotos_dao.g.dart';

@DriftAccessor(tables: [Fotos, Bovinos])
class FotosDao extends DatabaseAccessor<AppDatabase> with _$FotosDaoMixin {
  FotosDao(super.db);

  Stream<List<Foto>> watchFotosByBovinoId(int bovinoId) =>
      (select(db.fotos)..where((f) => f.bovinoId.equals(bovinoId))).watch();

  Future<List<Foto>> getFotosByBovinoId(int bovinoId) =>
      (select(db.fotos)..where((f) => f.bovinoId.equals(bovinoId))).get();

  Future<Foto?> getFotoById(int id) =>
      (select(db.fotos)..where((f) => f.id.equals(id))).getSingleOrNull();

  Future<int> insertFoto(FotosCompanion foto) =>
      into(db.fotos).insert(foto);

  Future<void> deleteFoto(int id) =>
      (delete(db.fotos)..where((f) => f.id.equals(id))).go();
}
