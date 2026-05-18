import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Toros extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Un bovino solo puede ser toro una vez
  IntColumn get bovinoId =>
      integer().unique().references(Bovinos, #id)();
}
