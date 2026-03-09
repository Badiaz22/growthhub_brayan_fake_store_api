import 'package:brayan_fake_store_api/src/data/models/geolocation_model.dart';
import 'package:brayan_fake_store_api/src/domain/entities/address_entity.dart';

/// Modelo de datos para [AddressEntity] — agrega serialización JSON.
class AddressModel extends AddressEntity {
  const AddressModel({
    required super.city,
    required super.street,
    required super.number,
    required super.zipcode,
    required super.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    city: json['city'] as String,
    street: json['street'] as String,
    number: json['number'] as int,
    zipcode: json['zipcode'] as String,
    geolocation: GeolocationModel.fromJson(
      json['geolocation'] as Map<String, dynamic>,
    ),
  );

  Map<String, dynamic> toJson() => {
    'city': city,
    'street': street,
    'number': number,
    'zipcode': zipcode,
    'geolocation': {'lat': geolocation.lat, 'long': geolocation.long},
  };
}
