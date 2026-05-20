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
├── app/           # MaterialApp.router + GoRouter (9 routes)
├── core/
│   ├── database/  # Drift schema (13 tables), DAOs, platform connections
│   ├── models/    # Cross-table JOIN models (e.g. BovinoWithDueno)
│   ├── providers/ # Database singleton provider
│   ├── seeds/     # Test data generator (debug only)
│   └── utils/     # NoAccentFormatter (strips accents on input)
└── features/
    ├── bovinos/   # Cattle: list, form, providers
    ├── duenos/    # Owners: list, form, providers
    └── lotes/     # Lots: list, form, providers
```

### Database (Drift)

`AppDatabase` in `lib/core/database/app_database.dart` defines 13 tables. Each table is a separate file under `lib/core/database/tables/`. Current schema version: 2 (v1→v2 recreated Lotes table to drop a CHECK constraint on `clave`, preserving data).

**Core cattle & ownership:**
- **Bovinos** — cattle record (areteId UNIQUE, nombre nullable+UNIQUE, sexo: M/H, estado: activo/vendido/muerto, loteId, razaId)
- **Pertenencia** — ownership history; `fechaFin IS NULL` = current owner
- **Lotes** — lot categories; seeded with 5 records (R=Reemplazo, O=Ordeña, H=Horras, E=Engorda, C=Crías)
- **Razas** — cattle breeds; seeded with 20 breeds (Angus, Hereford, etc.) on first DB creation
- **Duenos** — owners (nombre, telefono)

**Reproduction subsystem** (tables only — no UI implemented yet):
- **Progenie** — lineage (bovinoPadreId, bovinaMadreId → bovinoId; UNIQUE per offspring)
- **Toros** — bull designation (UNIQUE bovinoId)
- **Partos** — birth events
- **RegistroReproductivo** — breeding events (tipo, fechaProbableParto, toroId)

**Health & commerce:**
- **Vacunas** — vaccination records (nombreVacuna, fechaAplicacion, proximaDosis)
- **Tratamientos** — medical treatments (veterinario, fecha)
- **Ventas** — auto-populated when bovino estado → "vendido"
- **Fotos** — photo attachments; `rutaFoto` stores local path under `{appDocumentsDir}/bovinos/{bovinoId}/`

After changing any table class or DAO, run `build_runner build` to regenerate `.g.dart` files.

### DAOs

**BovinosDao** (`lib/core/database/daos/bovinos_dao.dart`) — also owns Lotes and Razas operations:
- `watchBovinosWithDueno()` — main reactive stream via LEFT JOIN on Pertenencia/Duenos
- `insertBovinoWithDueno()` — transaction: creates Bovino + optional initial Pertenencia row
- `transferirDueno()` — sets fechaFin on current Pertenencia, opens new one (audit trail preserved)
- `upsertVenta()` — called automatically when estado changes to "vendido"
- `deleteBovinoWithChildren()` — cascade deletes in FK-safe order: Vacunas/Tratamientos/Partos/Fotos/Ventas → RegistroReproductivo/Toros → Progenie → Pertenencia → Bovino
- `deleteLoteClean()` — nullifies loteId on affected bovinos before deleting the lot

**DuenosDao** (`lib/core/database/daos/duenos_dao.dart`):
- `watchAllDuenos()`, `getAllDuenos()` — ordered by nombre
- `deleteDuenoClean()` — deletes Pertenencia records before deleting owner

**FotosDao** (`lib/core/database/daos/fotos_dao.dart`):
- `watchFotosByBovinoId()`, `insertFoto()`, `deleteFoto()`

### State Management

Riverpod `StreamProvider`s in `lib/features/*/presentation/providers/` expose Drift watch streams directly to the UI. Form state uses `AsyncNotifier` (e.g. `BovinoFormNotifier`) which handles validation, transactions, and ownership transfers. Validation (arete/nombre uniqueness) lives in the Notifier, not in Flutter form validators.

### Navigation

`lib/app/router.dart` uses GoRouter with 9 routes. Edit forms receive the full model object (`BovinoWithDueno`, `Dueno`, `Lote`) via `extra` — not just an ID — to avoid a DB lookup on navigation.

### UI Patterns

- `BovinosListScreen` is adaptive: `DataTable` for screens ≥640px, `ListView` for mobile.
- Filter state (search, estado, sexo, edad range/min/max, sort field+direction) is local `StatefulWidget` state — not in Riverpod.
- Bovino form shows estado field only in edit mode; `fechaMuerte`/`fechaVenta` appear conditionally based on estado value.
- The "quick add owner" button in the bovino form opens a dialog without leaving the form screen. Lotes cannot be created inline from the bovino form.
- Photo management in bovino form tracks `_newPhotoFiles` and `_deletedPhotoIds` locally; files are written/deleted during `save()`.
- `NoAccentFormatter` (`lib/core/utils/text_formatters.dart`) strips accented characters on input — applied to areteId, nombre, and other text fields.
- Test data button (`SeedTestData.populate()`) is wrapped in `kDebugMode` guard.
