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
import 'daos/fotos_dao.dart';

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
  daos: [BovinosDao, DuenosDao, FotosDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seedData();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // Recreate lotes without the CHECK(clave IN ...) constraint
            await customStatement('PRAGMA foreign_keys = OFF');
            await customStatement('''
              CREATE TABLE lotes_new (
                id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                clave TEXT NOT NULL UNIQUE,
                descripcion TEXT
              )
            ''');
            await customStatement('INSERT INTO lotes_new SELECT id, clave, descripcion FROM lotes');
            await customStatement('DROP TABLE lotes');
            await customStatement('ALTER TABLE lotes_new RENAME TO lotes');
            await customStatement('PRAGMA foreign_keys = ON');
          }
          if (from < 3) {
            await m.addColumn(bovinos, bovinos.numControl);
          }
        },
      );

  Future<void> _seedData() async {
    await batch((b) {
      b.insertAll(lotes, [
        const LotesCompanion(clave: Value('R'), descripcion: Value('Reemplazo')),
        const LotesCompanion(clave: Value('O'), descripcion: Value('Ordeña')),
        const LotesCompanion(clave: Value('H'), descripcion: Value('Horras')),
        const LotesCompanion(clave: Value('E'), descripcion: Value('Engorda')),
        const LotesCompanion(clave: Value('C'), descripcion: Value('Crías')),
      ]);
      b.insertAll(razas, const [
        RazasCompanion(nombre: Value('Angus')),
        RazasCompanion(nombre: Value('Hereford')),
        RazasCompanion(nombre: Value('Charolais')),
        RazasCompanion(nombre: Value('Simmental')),
        RazasCompanion(nombre: Value('Limousin')),
        RazasCompanion(nombre: Value('Brahman')),
        RazasCompanion(nombre: Value('Gyr')),
        RazasCompanion(nombre: Value('Nelore')),
        RazasCompanion(nombre: Value('Indobrasil')),
        RazasCompanion(nombre: Value('Pardo Suizo')),
        RazasCompanion(nombre: Value('Holstein')),
        RazasCompanion(nombre: Value('Beefmaster')),
        RazasCompanion(nombre: Value('Brangus')),
        RazasCompanion(nombre: Value('Simbrah')),
        RazasCompanion(nombre: Value('Charbray')),
        RazasCompanion(nombre: Value('Criollo')),
        RazasCompanion(nombre: Value('Suizo Americano')),
        RazasCompanion(nombre: Value('Romagnola')),
        RazasCompanion(nombre: Value('Sardo Negro')),
        RazasCompanion(nombre: Value('Cruza')),
      ]);
    });
  }

  static QueryExecutor _openConnection() => openConnection();
}
