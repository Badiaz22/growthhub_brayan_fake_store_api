import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: reemplaza un usuario completo (PUT). Retorna el recurso actualizado.
class UpdateUserUseCase {
  final UserRepository _repository;

  const UpdateUserUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(
    int id,
    Map<String, dynamic> userData,
  ) => _repository.updateUser(id, userData);
}
