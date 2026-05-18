import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Tratamientos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  TextColumn get descripcion => text()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get veterinario => text().nullable()();
}
