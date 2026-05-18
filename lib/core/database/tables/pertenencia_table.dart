import 'package:drift/drift.dart';
import 'bovinos_table.dart';
import 'duenos_table.dart';

class Pertenencia extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  IntColumn get duenoId => integer().references(Duenos, #id)();
  DateTimeColumn get fechaInicio => dateTime()();
  // NULL = dueño actual
  DateTimeColumn get fechaFin => dateTime().nullable()();
}
