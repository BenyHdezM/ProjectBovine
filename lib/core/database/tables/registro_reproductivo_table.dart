import 'package:drift/drift.dart';
import 'bovinos_table.dart';
import 'toros_table.dart';

class RegistroReproductivo extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  // 'monta', 'inseminacion', 'diagnostico_gestacion', 'secado', etc.
  TextColumn get tipo => text()();
  TextColumn get diagnostico => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  DateTimeColumn get fechaProbableParto => dateTime().nullable()();
  IntColumn get toroId =>
      integer().nullable().references(Toros, #id)();
}
