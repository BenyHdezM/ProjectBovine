import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/bovinos_table.dart';
import '../tables/duenos_table.dart';
import '../tables/fotos_table.dart';
import '../tables/lotes_table.dart';
import '../tables/partos_table.dart';
import '../tables/pertenencia_table.dart';
import '../tables/progenie_table.dart';
import '../tables/razas_table.dart';
import '../tables/registro_reproductivo_table.dart';
import '../tables/toros_table.dart';
import '../tables/tratamientos_table.dart';
import '../tables/vacunas_table.dart';
import '../tables/ventas_table.dart';
import '../models/bovino_with_dueno.dart';

part 'bovinos_dao.g.dart';

@DriftAccessor(
    tables: [Bovinos, Pertenencia, Duenos, Razas, Lotes, Ventas, Vacunas, Tratamientos, Partos, Toros, Progenie, RegistroReproductivo, Fotos])
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

  Future<int> insertLote(LotesCompanion lote) => into(db.lotes).insert(lote);

  Future<bool> updateLote(LotesCompanion lote) => update(db.lotes).replace(lote);

  Future<void> deleteLoteClean(int id) => transaction(() async {
        await (update(db.bovinos)..where((b) => b.loteId.equals(id)))
            .write(const BovinosCompanion(loteId: Value(null)));
        await (delete(db.lotes)..where((l) => l.id.equals(id))).go();
      });

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

  /// Elimina un bovino y todos sus registros relacionados.
  Future<void> deleteBovinoWithChildren(int id) async {
    await transaction(() async {
      // Tablas hijas directas de Bovinos
      await (delete(db.vacunas)..where((v) => v.bovinoId.equals(id))).go();
      await (delete(db.tratamientos)..where((t) => t.bovinoId.equals(id))).go();
      await (delete(db.partos)..where((p) => p.bovinoId.equals(id))).go();
      await (delete(db.fotos)..where((f) => f.bovinoId.equals(id))).go();
      await (delete(db.ventas)..where((v) => v.bovinoId.equals(id))).go();

      // Registro reproductivo (bovinoId)
      await (delete(db.registroReproductivo)
            ..where((r) => r.bovinoId.equals(id)))
          .go();

      // Toros (bovinoId)
      await (delete(db.toros)..where((t) => t.bovinoId.equals(id))).go();

      // Progenie como hijo
      await (delete(db.progenie)..where((p) => p.bovinoId.equals(id))).go();

      // Progenie como padre/madre
      await (delete(db.progenie)
            ..where((p) =>
                p.bovinoPadreId.equals(id) | p.bovinaMadreId.equals(id)))
          .go();

      // Pertenencia
      await (delete(db.pertenencia)
            ..where((p) => p.bovinoId.equals(id))).go();

      // Finalmente el bovino
      await (db.delete(db.bovinos)..where((b) => b.id.equals(id))).go();
    });
  }

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

  Future<ProgenieData?> getProgenieByBovinoId(int bovinoId) =>
      (select(db.progenie)..where((p) => p.bovinoId.equals(bovinoId)))
          .getSingleOrNull();

  Future<void> upsertProgenie(
    int bovinoId, {
    int? madreId,
    int? padreId,
  }) async {
    if (madreId == null && padreId == null) {
      await (delete(db.progenie)..where((p) => p.bovinoId.equals(bovinoId)))
          .go();
      return;
    }
    await into(db.progenie).insertOnConflictUpdate(
      ProgenieCompanion(
        bovinoId: Value(bovinoId),
        bovinaMadreId: Value(madreId),
        bovinoPadreId: Value(padreId),
      ),
    );
  }
}
