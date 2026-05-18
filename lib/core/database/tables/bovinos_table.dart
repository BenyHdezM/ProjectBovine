import 'package:drift/drift.dart';
import 'lotes_table.dart';
import 'razas_table.dart';

class Bovinos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get areteId => text().unique()();
  // nullable; la unicidad se maneja con uniqueKeys para permitir múltiples NULLs
  TextColumn get nombre => text().nullable()();
  // M = Macho, H = Hembra
  TextColumn get sexo =>
      text().customConstraint("NOT NULL CHECK(sexo IN ('M','H'))")();
  DateTimeColumn get fechaNacimiento => dateTime().nullable()();
  DateTimeColumn get fechaMuerte => dateTime().nullable()();
  IntColumn get loteId => integer().nullable().references(Lotes, #id)();
  TextColumn get upp => text().nullable()();
  IntColumn get razaId => integer().nullable().references(Razas, #id)();
  TextColumn get estado => text().customConstraint(
      "NOT NULL DEFAULT 'activo' CHECK(estado IN ('activo','vendido','muerto'))")();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {nombre}
      ];
}
