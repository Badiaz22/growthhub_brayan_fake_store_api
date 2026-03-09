import 'package:brayan_fake_store_api/src/domain/entities/name_entity.dart';

/// Modelo de datos para [NameEntity] — agrega serialización JSON.
class NameModel extends NameEntity {
  const NameModel({required super.firstname, required super.lastname});

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
  );

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
  };
}
