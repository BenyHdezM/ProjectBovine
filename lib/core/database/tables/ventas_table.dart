import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Ventas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  DateTimeColumn get fechaVenta => dateTime()();
  RealColumn get precio => real().nullable()();
  TextColumn get comprador => text().nullable()();
}
