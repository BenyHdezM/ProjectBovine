// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duenos_dao.dart';

// ignore_for_file: type=lint
mixin _$DuenosDaoMixin on DatabaseAccessor<AppDatabase> {
  $DuenosTable get duenos => attachedDatabase.duenos;
  $LotesTable get lotes => attachedDatabase.lotes;
  $RazasTable get razas => attachedDatabase.razas;
  $BovinosTable get bovinos => attachedDatabase.bovinos;
  $PertenenciaTable get pertenencia => attachedDatabase.pertenencia;
  DuenosDaoManager get managers => DuenosDaoManager(this);
}

class DuenosDaoManager {
  final _$DuenosDaoMixin _db;
  DuenosDaoManager(this._db);
  $$DuenosTableTableManager get duenos =>
      $$DuenosTableTableManager(_db.attachedDatabase, _db.duenos);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db.attachedDatabase, _db.lotes);
  $$RazasTableTableManager get razas =>
      $$RazasTableTableManager(_db.attachedDatabase, _db.razas);
  $$BovinosTableTableManager get bovinos =>
      $$BovinosTableTableManager(_db.attachedDatabase, _db.bovinos);
  $$PertenenciaTableTableManager get pertenencia =>
      $$PertenenciaTableTableManager(_db.attachedDatabase, _db.pertenencia);
}
