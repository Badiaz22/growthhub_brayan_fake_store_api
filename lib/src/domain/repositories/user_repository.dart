import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

/// Contrato que define todas las operaciones de usuarios expuestas por el paquete.
///
/// La capa de datos provee una implementación concreta; la capa de dominio
/// y los casos de uso dependen únicamente de esta interfaz
/// (Principio de Inversión de Dependencias).
abstract interface class UserRepository {
  /// Retorna todos los usuarios, con paginación y ordenamiento opcionales.
  Future<Either<Failure, List<UserEntity>>> getUsers({
    int? limit,
    String? sort,
  });

  /// Retorna un único usuario por su [id].
  Future<Either<Failure, UserEntity>> getUserById(int id);

  /// Crea un nuevo usuario. Retorna el recurso con su id asignado.
  Future<Either<Failure, UserEntity>> createUser(Map<String, dynamic> userData);

  /// Reemplaza un usuario completo (actualización PUT).
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  );

  /// Actualiza parcialmente un usuario (PATCH).
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  );

  /// Elimina un usuario y retorna el recurso eliminado.
  Future<Either<Failure, UserEntity>> deleteUser(int id);
}
