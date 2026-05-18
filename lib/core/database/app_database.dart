import 'package:drift/drift.dart';
import 'connection/unsupported.dart'
    if (dart.library.io) 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';

import 'tables/bovinos_table.dart';
import 'tables/duenos_table.dart';
import 'tables/fotos_table.dart';
import 'tables/lotes_table.dart';
import 'tables/partos_table.dart';
import 'tables/pertenencia_table.dart';
import 'tables/progenie_table.dart';
import 'tables/razas_table.dart';
import 'tables/registro_reproductivo_table.dart';
import 'tables/toros_table.dart';
import 'tables/tratamientos_table.dart';
import 'tables/vacunas_table.dart';
import 'tables/ventas_table.dart';
import 'daos/bovinos_dao.dart';
import 'daos/duenos_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Razas,
    Lotes,
    Duenos,
    Bovinos,
    Pertenencia,
    Progenie,
    Partos,
    Ventas,
    Toros,
    Vacunas,
    Tratamientos,
    RegistroReproductivo,
    Fotos,
  ],
  daos: [BovinosDao, DuenosDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seedData();
        },
      );

  Future<void> _seedData() async {
    // Lotes predeterminados
    await batch((b) {
      b.insertAll(lotes, [
        const LotesCompanion(clave: Value('R'), descripcion: Value('Reemplazo')),
        const LotesCompanion(clave: Value('O'), descripcion: Value('Ordeña')),
        const LotesCompanion(clave: Value('H'), descripcion: Value('Horras')),
        const LotesCompanion(clave: Value('E'), descripcion: Value('Engorda')),
      ]);
    });
  }

  static QueryExecutor _openConnection() => openConnection();
}
