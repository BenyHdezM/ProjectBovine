import 'package:drift/drift.dart';
import 'bovinos_table.dart';

class Progenie extends Table {
  IntColumn get id => integer().autoIncrement()();
  // La cría solo puede tener un registro de progenie
  @ReferenceName('progenieHijoRefs')
  IntColumn get bovinoId =>
      integer().unique().references(Bovinos, #id)();
  @ReferenceName('progeniePadreRefs')
  IntColumn get bovinoPadreId =>
      integer().nullable().references(Bovinos, #id)();
  @ReferenceName('progenieMadreRefs')
  IntColumn get bovinaMadreId =>
      integer().nullable().references(Bovinos, #id)();
}
