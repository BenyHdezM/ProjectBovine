import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/bovinos_table.dart';
import '../tables/duenos_table.dart';
import '../tables/lotes_table.dart';
import '../tables/pertenencia_table.dart';
import '../tables/razas_table.dart';
import '../tables/ventas_table.dart';
import '../models/bovino_with_dueno.dart';

part 'bovinos_dao.g.dart';

@DriftAccessor(tables: [Bovinos, Pertenencia, Duenos, Razas, Lotes, Ventas])
class BovinosDao extends DatabaseAccessor<AppDatabase>
    with _$BovinosDaoMixin {
  BovinosDao(super.db);

  /// Stream principal: arete, nombre, dueño actual (pertenencia.fecha_fin IS NULL)
  Stream<List<BovinoWithDueno>> watchBovinosWithDueno() {
    final query = select(db.bovinos).join([
      leftOuterJoin(
        db.pertenencia,
        db.pertenencia.bovinoId.equalsExp(db.bovinos.id) &
            db.pertenencia.fechaFin.isNull(),
      ),
      leftOuterJoin(
        db.duenos,
        db.duenos.id.equalsExp(db.pertenencia.duenoId),
      ),
    ])
      ..orderBy([OrderingTerm(expression: db.bovinos.areteId)]);

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => BovinoWithDueno(
                  bovino: row.readTable(db.bovinos),
                  dueno: row.readTableOrNull(db.duenos),
                ),
              )
              .toList(),
        );
  }

  Future<Bovino?> findByAreteId(String areteId) =>
      (select(db.bovinos)..where((b) => b.areteId.equals(areteId)))
          .getSingleOrNull();

  Future<Bovino?> findByNombre(String nombre) =>
      (select(db.bovinos)..where((b) => b.nombre.equals(nombre)))
          .getSingleOrNull();

  Future<List<Raza>> getAllRazas() => select(db.razas).get();
  Stream<List<Raza>> watchAllRazas() => select(db.razas).watch();

  Future<List<Lote>> getAllLotes() => select(db.lotes).get();
  Stream<List<Lote>> watchAllLotes() => select(db.lotes).watch();

  /// Inserta un bovino y opcionalmente le asigna un dueño en una transacción.
  Future<int> insertBovinoWithDueno(
    BovinosCompanion bovino, {
    int? duenoId,
  }) =>
      transaction(() async {
        final id = await into(db.bovinos).insert(bovino);
        if (duenoId != null) {
          await into(db.pertenencia).insert(
            PertenenciaCompanion(
              bovinoId: Value(id),
              duenoId: Value(duenoId),
              fechaInicio: Value(DateTime.now()),
            ),
          );
        }
        return id;
      });

  Future<bool> updateBovino(BovinosCompanion entry) =>
      update(db.bovinos).replace(entry);

  Future<int> deleteBovino(int id) =>
      (delete(db.bovinos)..where((b) => b.id.equals(id))).go();

  /// Inserta o actualiza el registro de venta para un bovino.
  Future<void> upsertVenta(int bovinoId, DateTime fechaVenta) async {
    final existing = await (select(db.ventas)
          ..where((v) => v.bovinoId.equals(bovinoId)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(db.ventas)..where((v) => v.id.equals(existing.id)))
          .write(VentasCompanion(fechaVenta: Value(fechaVenta)));
    } else {
      await into(db.ventas).insert(
        VentasCompanion(
          bovinoId: Value(bovinoId),
          fechaVenta: Value(fechaVenta),
        ),
      );
    }
  }

  /// Cambia el dueño actual: cierra la pertenencia vigente y abre una nueva.
  Future<void> transferirDueno(int bovinoId, int nuevoDuenoId) =>
      transaction(() async {
        await (update(db.pertenencia)
              ..where(
                (p) =>
                    p.bovinoId.equals(bovinoId) & p.fechaFin.isNull(),
              ))
            .write(PertenenciaCompanion(fechaFin: Value(DateTime.now())));
        await into(db.pertenencia).insert(
          PertenenciaCompanion(
            bovinoId: Value(bovinoId),
            duenoId: Value(nuevoDuenoId),
            fechaInicio: Value(DateTime.now()),
          ),
        );
      });
}
