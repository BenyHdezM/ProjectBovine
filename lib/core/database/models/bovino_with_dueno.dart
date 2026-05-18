import '../app_database.dart';

/// Resultado de la consulta JOIN para la lista principal.
class BovinoWithDueno {
  final Bovino bovino;
  final Dueno? dueno;

  const BovinoWithDueno({required this.bovino, this.dueno});
}
