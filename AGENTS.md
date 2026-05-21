# AGENTS.md

## Commands

Always use `fvm flutter` instead of `flutter` directly. Flutter version is `3.41.9` (`.fvmrc`).

```bash
# Run the app
fvm flutter run

# Linux desktop
fvm flutter run -d linux

# Android
fvm flutter run -d android-emulator

# Chrome web
fvm flutter run -d chrome

# Run a single test
fvm flutter test test/widget_test.dart

# Run all tests
fvm flutter test

# Lint / analyze
fvm flutter analyze

# Code generation after Drift table/DAO changes
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Commit Conventions

Se usa [Conventional Commits](https://www.conventionalcomm.org/) con descripciones en español:

| Tipo      | Descripción                          | Ejemplo                                              |
|-----------|--------------------------------------|------------------------------------------------------|
| `feat`    | Nueva funcionalidad                  | `feat: agregar gestión de fotos para bovinos`        |
| `fix`     | Corrección de bug                    | `fix: validar fecha de nacimiento en formulario`     |
| `chore`   | Tareas generales, deps, config       | `chore: actualizar dependencia drift a 3.0`          |
| `refactor`| Cambio de código sin cambiar behavior| `refactor: renombrar variable loteId por granjaId`   |
| `docs`    | Documentación                        | `docs: agregar guía de setup en README`              |

Formato: `<tipo>: <descripción en español, minúscula>`

## Architecture

Feature-based under `lib/`:

```
lib/
├── app/           # VacunoApp + GoRouter (10 routes in router.dart)
├── core/
│   ├── database/  # Drift: AppDatabase, 13 tables, 3 DAOs, seeds
│   ├── models/    # JOIN models (BovinoWithDueno, Dueno, etc.)
└── features/
    ├── bovinos/   # Cattle: list, form (edit & new), detail, providers
    ├── duenos/    # Owners: list, form, providers
    └── lotes/     # Lots: list, form, providers
```

Each feature has only `presentation/` subdirectories (screens + providers).

### Database (Drift)

13 tables in `lib/core/database/tables/`. 3 DAOs in `lib/core/database/daos/`: BovinosDao, DuenosDao, FotosDao.

Key tables:
- **Bovinos** — core cattle record (areteId, nombre, sexo, estado, loteId, razaId, numControl)
- **Pertenencia** — ownership history; `fechaFin IS NULL` means current owner
- **Lotes** — lot categories with seeded clave values: R, O, H, E, C
- **Ventas** — auto-populated when bovino estado → "vendido"
- **Schema version** — 3 (see `AppDatabase.schemaVersion`)

After changing any table class or DAO, regenerate: `fvm flutter pub run build_runner build --delete-conflicting-outputs`. Generated `.g.dart` files are committed.

### State Management

Riverpod `StreamProvider`s in `lib/features/*/presentation/providers/` expose Drift watch streams directly to the UI. Form state uses `AsyncNotifier` (e.g. `BovinoFormNotifier`) which handles validation, transactions, and ownership transfers. Filter state is local `StatefulWidget` state — not Riverpod.

### Navigation

GoRouter in `lib/app/router.dart`. Forms receive the full model object via GoRouter `extra`:
- `/bovinos/:id` → `Bovino?`
- `/bovinos/:id/detail` → `BovinoWithDueno`
- `/duenos/:id` → `Dueno?`
- `/lotes/:id` → `Lote?`

Routes: `/`, `/bovinos/new`, `/bovinos/:id`, `/bovinos/:id/detail`, `/duenos`, `/duenos/new`, `/duenos/:id`, `/lotes`, `/lotes/new`, `/lotes/:id`.

### UI Patterns

- List screens use adaptive layout: `DataTable` for ≥640px, `ListView` for mobile.
- "Quick add owner" button in bovino form opens a dialog without leaving the form screen.

### Gotchas

- **Drift migrations** are defined inline in `AppDatabase.migration` (onUpgrade callback). Schema version is 3.
- **Seed data** (lotes, razas) is loaded on fresh DB creation in `_seedData()`, called from `onCreate`.
- **Connection** uses native SQLite for mobile/desktop and a separate web executor (`connection/web.dart`).
