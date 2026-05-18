// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bovinos_dao.dart';

// ignore_for_file: type=lint
mixin _$BovinosDaoMixin on DatabaseAccessor<AppDatabase> {
  $LotesTable get lotes => attachedDatabase.lotes;
  $RazasTable get razas => attachedDatabase.razas;
  $BovinosTable get bovinos => attachedDatabase.bovinos;
  $DuenosTable get duenos => attachedDatabase.duenos;
  $PertenenciaTable get pertenencia => attachedDatabase.pertenencia;
  $VentasTable get ventas => attachedDatabase.ventas;
  $VacunasTable get vacunas => attachedDatabase.vacunas;
  $TratamientosTable get tratamientos => attachedDatabase.tratamientos;
  $PartosTable get partos => attachedDatabase.partos;
  $TorosTable get toros => attachedDatabase.toros;
  $ProgenieTable get progenie => attachedDatabase.progenie;
  $RegistroReproductivoTable get registroReproductivo =>
      attachedDatabase.registroReproductivo;
  $FotosTable get fotos => attachedDatabase.fotos;
  BovinosDaoManager get managers => BovinosDaoManager(this);
}

class BovinosDaoManager {
  final _$BovinosDaoMixin _db;
  BovinosDaoManager(this._db);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db.attachedDatabase, _db.lotes);
  $$RazasTableTableManager get razas =>
      $$RazasTableTableManager(_db.attachedDatabase, _db.razas);
  $$BovinosTableTableManager get bovinos =>
      $$BovinosTableTableManager(_db.attachedDatabase, _db.bovinos);
  $$DuenosTableTableManager get duenos =>
      $$DuenosTableTableManager(_db.attachedDatabase, _db.duenos);
  $$PertenenciaTableTableManager get pertenencia =>
      $$PertenenciaTableTableManager(_db.attachedDatabase, _db.pertenencia);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db.attachedDatabase, _db.ventas);
  $$VacunasTableTableManager get vacunas =>
      $$VacunasTableTableManager(_db.attachedDatabase, _db.vacunas);
  $$TratamientosTableTableManager get tratamientos =>
      $$TratamientosTableTableManager(_db.attachedDatabase, _db.tratamientos);
  $$PartosTableTableManager get partos =>
      $$PartosTableTableManager(_db.attachedDatabase, _db.partos);
  $$TorosTableTableManager get toros =>
      $$TorosTableTableManager(_db.attachedDatabase, _db.toros);
  $$ProgenieTableTableManager get progenie =>
      $$ProgenieTableTableManager(_db.attachedDatabase, _db.progenie);
  $$RegistroReproductivoTableTableManager get registroReproductivo =>
      $$RegistroReproductivoTableTableManager(
          _db.attachedDatabase, _db.registroReproductivo);
  $$FotosTableTableManager get fotos =>
      $$FotosTableTableManager(_db.attachedDatabase, _db.fotos);
}
