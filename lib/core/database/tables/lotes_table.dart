import 'package:drift/drift.dart';

class Lotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  // R=Reemplazo, O=Ordeña, H=Horras, E=Engorda
  TextColumn get clave => text().customConstraint('NOT NULL UNIQUE')();
  TextColumn get descripcion => text().nullable()();
}
