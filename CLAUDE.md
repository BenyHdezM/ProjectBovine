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

`AppDatabase` in `lib/core/database/app_database.dart` defines 13 tables. Each table is a separate file under `lib/core/database/tables/`. Key tables:

- **Bovinos** — core cattle record (areteId, nombre, sexo, estado, loteId, razaId)
- **Pertenencia** — ownership history; `fechaFin IS NULL` means current owner
- **Lotes** — lot categories with predefined clave values: R, O, H, E
- **Ventas** — auto-populated when bovino estado → "vendido"

After changing any table class or DAO, run `build_runner build` to regenerate `.g.dart` files.

### State Management

Riverpod `StreamProvider`s in `lib/features/*/presentation/providers/` expose Drift watch streams directly to the UI. Form state uses `AsyncNotifier` (e.g. `BovinoFormNotifier`) which handles validation, transactions, and ownership transfers.

### BovinosDao

`lib/core/database/daos/bovinos_dao.dart` contains the critical queries:

- `watchBovinosWithDueno()` — main reactive stream using LEFT JOIN via `Pertenencia`
- `insertBovinoWithDueno()` — transaction that creates Bovino + initial Pertenencia row
- `transferirDueno()` — closes current Pertenencia (sets fechaFin) and opens a new one
- `upsertVenta()` — called automatically when estado changes to "vendido"

### Navigation

`lib/app/router.dart` uses GoRouter. Edit forms receive the full `BovinoWithDueno` object via `extra` (not just an ID) to avoid an extra DB lookup on navigation.

### UI Patterns

- `BovinosListScreen` is adaptive: `DataTable` for screens ≥640px, `ListView` for mobile.
- Filter state (search text, estado, sexo) is local `StatefulWidget` state — not in Riverpod.
- The "quick add owner" button in the bovino form opens a dialog without leaving the form screen.
- Test data button (`SeedTestData.populate()`) is wrapped in `kDebugMode` guard.
