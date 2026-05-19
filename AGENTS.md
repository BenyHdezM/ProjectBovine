# AGENTS.md

## Commands

Always use `fvm flutter` instead of `flutter` directly.

```bash
# Run the app
fvm flutter run

# Run tests (single file or all)
fvm flutter test test/widget_test.dart   # single file
fvm flutter test                         # all tests

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
| `refactor`| Cambio de código sin cambiar behavior| `refactor: renomzar variable loteId por granjaId`    |
| `docs`    | Documentación (README, AGENTS.md)    | `docs: agregar guía de setup en README`              |

Formato: `<tipo>: <descripción en español, minúscula>`

Feature-based structure under `lib/`:

```
lib/
├── app/           # VacunoApp widget + GoRouter (6 routes)
├── core/
│   ├── database/  # Drift DB: AppDatabase, 13 tables in tables/, DAOs in daos/
│   ├── models/    # JOIN models (BovinoWithDueno)
│   ├── providers/ # Database singleton provider
│   └── seeds/     # SeedTestData.populate() — kDebugMode guarded
└── features/
    ├── bovinos/   # Cattle: list, form, providers
    └── duenos/    # Owners: list, form, providers
```

### Database (Drift)

13 tables in `lib/core/database/tables/`: Bovinos, Duenos, Pertenencia, Lotes, Razas, Ventas, Vacunas, Tratamientos, Partos, Toros, Progenie, RegistroReproductivo, Fotos.

Key tables:
- **Bovinos** — core cattle record (areteId, nombre, sexo, estado, loteId, razaId)
- **Pertenencia** — ownership history; `fechaFin IS NULL` means current owner
- **Lotes** — lot categories with predefined clave values: R, O, H, E
- **Ventas** — auto-populated when bovino estado → "vendido"

After changing any table class or DAO, run `build_runner build`. The generated `.g.dart` files are committed.

### State Management

Riverpod `StreamProvider`s in `lib/features/*/presentation/providers/` expose Drift watch streams directly to the UI. Form state uses `AsyncNotifier` (e.g. `BovinoFormNotifier`) which handles validation, transactions, and ownership transfers. Filter state is local `StatefulWidget` state — not Riverpod.

### Navigation

GoRouter in `lib/app/router.dart`. Edit forms receive the full model object (`BovinoWithDueno`, `Dueno`) via GoRouter `extra` (not just an ID) to avoid a DB lookup on navigation. Routes: `/`, `/bovinos/new`, `/bovinos/:id`, `/duenos`, `/duenos/new`, `/duenos/:id`.

### UI Patterns

- List screens use adaptive layout: `DataTable` for ≥640px, `ListView` for mobile.
- "Quick add owner" button in bovino form opens a dialog without leaving the form screen.
