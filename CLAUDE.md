# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

Always use `fvm flutter` instead of `flutter` directly.

```bash
# Run the app
fvm flutter run

# Run tests
fvm flutter test
fvm flutter test test/widget_test.dart   # single test file

# Lint
fvm flutter analyze

# Code generation (required after modifying Drift tables/DAOs)
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for code gen during development
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Architecture

Feature-based structure under `lib/`:

```
lib/
├── app/           # MaterialApp.router + GoRouter (6 routes)
├── core/
│   ├── database/  # Drift schema (13 tables), DAOs, platform connections
│   ├── models/    # Cross-table JOIN models (e.g. BovinoWithDueno)
│   ├── providers/ # Database singleton provider
│   └── seeds/     # Test data generator (debug only)
└── features/
    ├── bovinos/   # Cattle: list, form, providers
    └── duenos/    # Owners: list, form, providers
```

### Database (Drift)

`AppDatabase` in `lib/core/database/app_database.dart` defines 13 tables. Each table is a separate file under `lib/core/database/tables/`. Tables grouped by concern:

**Core cattle & ownership:**
- **Bovinos** — cattle record (areteId UNIQUE, nombre, sexo: M/H, estado: activo/vendido/muerto, loteId, razaId)
- **Pertenencia** — ownership history; `fechaFin IS NULL` = current owner
- **Lotes** — lot categories; seeded with 4 records (clave: R, O, H, E)
- **Razas** — cattle breeds; seeded with 20 breeds (Angus, Hereford, etc.) on first DB creation
- **Duenos** — owners (nombre, telefono)

**Reproduction subsystem** (tables defined, UI not fully integrated):
- **Progenie** — lineage (bovinoPadreId, bovinaMadreId → bovinoId; UNIQUE per offspring)
- **Toros** — bull designation (UNIQUE bovinoId)
- **Partos** — birth events
- **RegistroReproductivo** — breeding events (tipo, fechaProbableParto, toroId)

**Health & commerce:**
- **Vacunas** — vaccination records (nombreVacuna, fechaAplicacion, proximaDosis)
- **Tratamientos** — medical treatments (veterinario, fecha)
- **Ventas** — auto-populated when bovino estado → "vendido"
- **Fotos** — photo attachments; `rutaFoto` stores local filesystem path (captured via `image_picker`, stored via `path_provider`)

After changing any table class or DAO, run `build_runner build` to regenerate `.g.dart` files.

### DAOs

**BovinosDao** (`lib/core/database/daos/bovinos_dao.dart`):
- `watchBovinosWithDueno()` — main reactive stream via LEFT JOIN on Pertenencia/Duenos
- `insertBovinoWithDueno()` — transaction: creates Bovino + optional initial Pertenencia row
- `transferirDueno()` — sets fechaFin on current Pertenencia, opens new one (audit trail preserved)
- `upsertVenta()` — called automatically when estado changes to "vendido"
- `deleteBovinoWithChildren()` — cascade deletes all related records in dependency order (handles Progenie's dual FK as both padre/madre and hijo)

**DuenosDao** (`lib/core/database/daos/duenos_dao.dart`):
- `watchAllDuenos()`, `getAllDuenos()` — ordered by nombre
- `deleteDuenoClean()` — deletes Pertenencia records before deleting owner

**FotosDao** (`lib/core/database/daos/fotos_dao.dart`):
- `watchFotosByBovinoId()`, `insertFoto()`, `deleteFoto()`

### State Management

Riverpod `StreamProvider`s in `lib/features/*/presentation/providers/` expose Drift watch streams directly to the UI. Form state uses `AsyncNotifier` (e.g. `BovinoFormNotifier`) which handles validation, transactions, and ownership transfers.

### Navigation

`lib/app/router.dart` uses GoRouter. Edit forms receive the full model object (`BovinoWithDueno`, `Dueno`) via `extra` — not just an ID — to avoid a DB lookup on navigation.

### UI Patterns

- `BovinosListScreen` is adaptive: `DataTable` for screens ≥640px, `ListView` for mobile.
- Filter state (search text, estado, sexo) is local `StatefulWidget` state — not in Riverpod.
- The "quick add owner" button in the bovino form opens a dialog without leaving the form screen.
- Test data button (`SeedTestData.populate()`) is wrapped in `kDebugMode` guard.
