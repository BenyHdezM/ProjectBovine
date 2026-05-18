# Vacuno App

App de inventario bovino desarrollada en Flutter con Drift (SQLite) como base de datos local.

## Requisitos

- [FVM](https://fvm.app/) — Flutter Version Management
- Dart SDK (instalado vía FVM)

## Instalación

```bash
# Instalar FVM si no lo tienes
dart install global fvm

# Configurar la versión de Flutter del proyecto
fvm use flutter_3.29.1

# Obtener dependencias
fvm flutter pub get
```

## Ejecución

### Dispositivos disponibles

```bash
# Linux (escritorio)
fvm flutter run -d linux

# Android (conectar dispositivo o usar emulador)
fvm flutter run -d android-emulator

# Windows
fvm flutter run -d windows

# Chrome / Web
fvm flutter run -d chrome
```

### Modos de ejecución

```bash
# Debug (default, con DevTools)
fvm flutter run -d linux --debug

# Release
fvm flutter run -d linux --release

# Profile (rendimiento)
fvm flutter run -d linux --profile
```

## Testing

```bash
# Ejecutar todos los tests
fvm flutter test

# Ejecutar un archivo específico
fvm flutter test test/widget_test.dart
```

## Análisis estático

```bash
# Analizar código con lint
fvm flutter analyze
```

## Generación de código (Drift)

Después de modificar tablas o DAOs en Drift, regenerar los archivos `.g.dart`:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Para modo watch durante desarrollo:

```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Arquitectura

El proyecto sigue una estructura por features:

```
lib/
├── app/           # MaterialApp + GoRouter (6 rutas)
├── core/
│   ├── database/  # Drift schema (13 tablas), DAOs, conexiones nativas/web
│   ├── models/    # Modelos con JOIN (ej. BovinoWithDueno)
│   └── providers/ # Provider de base de datos
└── features/
    ├── bovinos/   # Inventario bovino: lista, formulario, proveedores
    └── duenos/    # Dueños: lista, formulario, proveedores
```

## Estado Management

- **Riverpod** con `StreamProvider` para streams reactivos desde Drift
- **AsyncNotifier** para formularios (validación, transacciones, transferencias)
