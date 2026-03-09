import 'package:brayan_fake_store_api/src/domain/entities/geolocation_entity.dart';

/// Modelo de datos para [GeolocationEntity] — agrega serialización JSON.
class GeolocationModel extends GeolocationEntity {
  const GeolocationModel({required super.lat, required super.long});

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      GeolocationModel(
        lat: json['lat'] as String,
        long: json['long'] as String,
      );

  Map<String, dynamic> toJson() => {'lat': lat, 'long': long};
}
