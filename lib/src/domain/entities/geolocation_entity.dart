/// Coordenadas geográficas asociadas a una [AddressEntity].
class GeolocationEntity {
  /// Latitud en formato cadena de texto (tal como la retorna la API).
  final String lat;

  /// Longitud en formato cadena de texto (tal como la retorna la API).
  final String long;

  const GeolocationEntity({required this.lat, required this.long});
}
