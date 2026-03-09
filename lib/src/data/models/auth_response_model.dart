import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';

/// Modelo de datos para [AuthResponseEntity] — agrega serialización JSON.
class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({required super.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(token: json['token'] as String);

  Map<String, dynamic> toJson() => {'token': token};
}
