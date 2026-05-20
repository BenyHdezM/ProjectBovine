// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fotos_dao.dart';

// ignore_for_file: type=lint
mixin _$FotosDaoMixin on DatabaseAccessor<AppDatabase> {
  $LotesTable get lotes => attachedDatabase.lotes;
  $RazasTable get razas => attachedDatabase.razas;
  $BovinosTable get bovinos => attachedDatabase.bovinos;
  $FotosTable get fotos => attachedDatabase.fotos;
  FotosDaoManager get managers => FotosDaoManager(this);
}

class FotosDaoManager {
  final _$FotosDaoMixin _db;
  FotosDaoManager(this._db);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db.attachedDatabase, _db.lotes);
  $$RazasTableTableManager get razas =>
      $$RazasTableTableManager(_db.attachedDatabase, _db.razas);
  $$BovinosTableTableManager get bovinos =>
      $$BovinosTableTableManager(_db.attachedDatabase, _db.bovinos);
  $$FotosTableTableManager get fotos =>
      $$FotosTableTableManager(_db.attachedDatabase, _db.fotos);
}
