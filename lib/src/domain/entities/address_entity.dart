import 'geolocation_entity.dart';

/// Dirección de envío o facturación de un [UserEntity].
class AddressEntity {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeolocationEntity geolocation;

  const AddressEntity({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });
}
