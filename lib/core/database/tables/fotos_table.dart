import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Fotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bovinoId => integer().references(Bovinos, #id)();
  TextColumn get rutaFoto => text()(); // ruta local del archivo
  DateTimeColumn get fechaCaptura =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get descripcion => text().nullable()();
}
