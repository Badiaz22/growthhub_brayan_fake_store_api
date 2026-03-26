import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:dartz/dartz.dart';

/// Contrato que define todas las operaciones de autenticación expuestas por el paquete.
///
/// La capa de datos provee una implementación concreta; la capa de dominio
/// y los casos de uso dependen únicamente de esta interfaz
/// (Principio de Inversión de Dependencias).
abstract interface class AuthRepository {
  /// Autentica un usuario y retorna un token JWT.
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  );
}
