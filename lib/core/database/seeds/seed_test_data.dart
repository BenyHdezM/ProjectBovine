import 'package:drift/drift.dart';
import '../app_database.dart';

typedef _BovinoRow = (
  String arete,
  String numControl,
  String? nombre,
  String sexo,
  String estado,
  int anio,
  int mes,
  int dia,
  int duenoIdx,
  int razaIdx,
);

const List<_BovinoRow> _datos = [
  ('T-001', '1001', 'La Bonita',    'H', 'activo',   2019,  3, 15, 0, 0),
  ('T-002', '1002', 'Tormenta',     'M', 'activo',   2018,  5, 10, 1, 1),
  ('T-003', '1003', 'Palomita',     'H', 'activo',   2020,  7,  1, 2, 2),
  ('T-004', '1004', 'Canela',       'H', 'vendido',  2017,  4, 20, 0, 3),
  ('T-005', '1005', 'El Robusto',   'M', 'activo',   2016,  8,  5, 3, 4),
  ('T-006', '1006', 'Manchada',     'H', 'activo',   2021,  2, 14, 1, 5),
  ('T-007', '1007', 'Rosaura',      'H', 'activo',   2022,  3, 11, 2, 6),
  ('T-008', '1008', 'Torito Negro', 'M', 'vendido',  2017,  6, 18, 3, 7),
  ('T-009', '1009', 'Valentina',    'H', 'activo',   2020,  9,  7, 0, 0),
  ('T-010', '1010', 'El Lucero',    'M', 'activo',   2019,  4, 22, 1, 1),
  ('T-011', '1011', 'Esperanza',    'H', 'activo',   2021,  1, 13, 2, 2),
  ('T-012', '1012', 'Ceniza',       'H', 'muerto',   2015,  6,  8, 3, 3),
  ('T-013', '1013', 'Manchita',     'H', 'activo',   2022,  3, 17, 0, 4),
  ('T-014', '1014', 'Trompuda',     'H', 'activo',   2020,  5, 25, 1, 5),
  ('T-015', '1015', 'El Grande',    'M', 'activo',   2018,  7, 30, 2, 6),
  ('T-016', '1016', 'Florecita',    'H', 'activo',   2021,  2, 12, 3, 7),
  ('T-017', '1017', 'Negrita',      'H', 'vendido',  2019,  4,  9, 0, 0),
  ('T-018', '1018', 'Estrellita',   'H', 'activo',   2023,  1, 15, 1, 1),
  ('T-019', '1019', 'Ronco',        'M', 'activo',   2017,  8, 20, 2, 2),
  ('T-020', '1020', 'La Serena',    'H', 'activo',   2020,  3, 27, 3, 3),
  ('T-021', '1021', 'Pachorra',     'H', 'activo',   2022,  5, 10, 0, 4),
  ('T-022', '1022', 'El Pinto',     'M', 'muerto',   2016,  7, 14, 1, 5),
  ('T-023', '1023', 'Azucena',      'H', 'activo',   2021,  2,  6, 2, 6),
  ('T-024', '1024', 'Consentida',   'H', 'activo',   2019,  4, 21, 3, 7),
  ('T-025', '1025', 'Pintado',      'M', 'activo',   2020,  8, 16, 0, 0),
  ('T-026', '1026', 'Primavera',    'H', 'activo',   2022,  1, 11, 1, 1),
  ('T-027', '1027', 'El Viejo',     'M', 'vendido',  2014,  7, 28, 2, 2),
  ('T-028', '1028', 'Rosita',       'H', 'activo',   2021,  3,  4, 3, 3),
  ('T-029', '1029', 'Mariposa',     'H', 'activo',   2023,  2, 19, 0, 4),
  ('T-030', '1030', 'El Bravo',     'M', 'activo',   2018,  5, 23, 1, 5),
  ('T-031', '1031', 'Libertad',     'H', 'activo',   2020,  1, 17, 2, 6),
  ('T-032', '1032', 'Cenicienta',   'H', 'muerto',   2017,  6,  8, 3, 7),
  ('T-033', '1033', 'Chaparrita',   'H', 'activo',   2022,  3, 13, 0, 0),
  ('T-034', '1034', 'El Moro',      'M', 'activo',   2019,  8, 26, 1, 1),
  ('T-035', '1035', 'Serena',       'H', 'activo',   2021,  2, 10, 2, 2),
  ('T-036', '1036', 'Morita',       'H', 'vendido',  2018,  4, 15, 3, 3),
  ('T-037', '1037', 'Lucinda',      'H', 'activo',   2023,  1, 22, 0, 4),
  ('T-038', '1038', 'El Cenizo',    'M', 'activo',   2020,  7, 18, 1, 5),
  ('T-039', '1039', 'Preciosa',     'H', 'activo',   2021,  3,  7, 2, 6),
  ('T-040', '1040', 'La Campiona',  'H', 'activo',   2022,  5, 30, 3, 7),
];

/// Inserta datos de prueba. Usa prefijo "T-" en aretes para no colisionar
/// con registros reales. Idempotente: omite bovinos ya existentes.
Future<void> seedTestData(AppDatabase db) async {
  // ── Razas ──────────────────────────────────────────────────────────────────
  final razaRows = await db.select(db.razas).get();
  final razaIds = razaRows.map((r) => r.id).toList();

  // ── Dueños ─────────────────────────────────────────────────────────────────
  const duenoData = [
    ('Benito Hernandez', '555-101-0001'),
    ('Maria Gonzalez',   '555-101-0002'),
    ('Carlos Martinez',  null),
    ('Rosa Avila',       '555-101-0003'),
  ];
  final duenoIds = <int>[];
  for (final (nombre, tel) in duenoData) {
    var row = await (db.select(db.duenos)
          ..where((d) => d.nombre.equals(nombre)))
        .getSingleOrNull();
    if (row == null) {
      final id = await db.into(db.duenos).insert(
        DuenosCompanion(nombre: Value(nombre), telefono: Value(tel)),
      );
      duenoIds.add(id);
    } else {
      duenoIds.add(row.id);
    }
  }

  // ── Lotes ─────────────────────────────────────────────────────────────────
  final lotes = await db.select(db.lotes).get();
  final loteByKey = {for (final l in lotes) l.clave: l.id};
  final claves = ['R', 'O', 'H', 'E'];

  // ── Bovinos ───────────────────────────────────────────────────────────────
  await db.transaction(() async {
    var i = 0;
    for (final (arete, numControl, nombre, sexo, estado, anio, mes, dia, duenoIdx, razaIdx)
        in _datos) {
      final existe = await (db.select(db.bovinos)
            ..where((b) => b.areteId.equals(arete)))
          .getSingleOrNull();
      if (existe != null) {
        i++;
        continue;
      }

      final loteId = loteByKey[claves[i % 4]];
      final razaId = razaIds.isNotEmpty ? razaIds[razaIdx % razaIds.length] : null;
      final fechaNac = DateTime(anio, mes, dia);
      final fechaMuerte =
          estado == 'muerto' ? fechaNac.add(const Duration(days: 900)) : null;

      final bovinoId = await db.into(db.bovinos).insert(
        BovinosCompanion(
          areteId: Value(arete),
          numControl: Value(numControl),
          nombre: Value(nombre),
          sexo: Value(sexo),
          estado: Value(estado),
          fechaNacimiento: Value(fechaNac),
          fechaMuerte: Value(fechaMuerte),
          loteId: Value(loteId),
          razaId: Value(razaId),
        ),
      );

      if (duenoIds.isNotEmpty) {
        await db.into(db.pertenencia).insert(
          PertenenciaCompanion(
            bovinoId: Value(bovinoId),
            duenoId: Value(duenoIds[duenoIdx % duenoIds.length]),
            fechaInicio: Value(fechaNac),
          ),
        );
      }

      if (estado == 'vendido') {
        await db.into(db.ventas).insert(
          VentasCompanion(
            bovinoId: Value(bovinoId),
            fechaVenta: Value(fechaNac.add(const Duration(days: 700))),
          ),
        );
      }

      i++;
    }
  });
}
