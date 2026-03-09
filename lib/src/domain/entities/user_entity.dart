import 'address_entity.dart';
import 'name_entity.dart';

/// Usuario registrado en la Fake Store.
class UserEntity {
  final int id;
  final String email;
  final String username;

  /// Contraseña retornada por la API (texto plano en la API de prueba).
  final String password;

  final NameEntity name;
  final AddressEntity address;
  final String phone;

  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });
}
