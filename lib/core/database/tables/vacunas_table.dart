import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Vacunas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  TextColumn get nombreVacuna => text()();
  DateTimeColumn get fechaAplicacion => dateTime()();
  TextColumn get descripcion => text().nullable()();
  DateTimeColumn get proximaDosis => dateTime().nullable()();
}
