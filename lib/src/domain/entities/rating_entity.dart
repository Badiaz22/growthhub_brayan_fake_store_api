/// Información de calificación asociada a un [ProductEntity].
class RatingEntity {
  /// Promedio de calificaciones de los usuarios (0.0 – 5.0).
  final double rate;

  /// Total de calificaciones registradas.
  final int count;

  const RatingEntity({required this.rate, required this.count});
}
