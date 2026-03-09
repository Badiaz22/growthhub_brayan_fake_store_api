import 'package:brayan_fake_store_api/src/data/models/address_model.dart';
import 'package:brayan_fake_store_api/src/data/models/name_model.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';

/// Modelo de datos para [UserEntity] — agrega serialización JSON.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.password,
    required super.name,
    required super.address,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    email: json['email'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    name: NameModel.fromJson(json['name'] as Map<String, dynamic>),
    address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    phone: json['phone'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'username': username,
    'password': password,
    'name': {'firstname': name.firstname, 'lastname': name.lastname},
    'address': {
      'city': address.city,
      'street': address.street,
      'number': address.number,
      'zipcode': address.zipcode,
      'geolocation': {
        'lat': address.geolocation.lat,
        'long': address.geolocation.long,
      },
    },
    'phone': phone,
  };
}
