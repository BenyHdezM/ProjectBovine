import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Partos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  DateTimeColumn get fechaParto => dateTime()();
  TextColumn get notas => text().nullable()();
}
