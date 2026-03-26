import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene un único usuario por su [id] numérico.
class GetUserByIdUseCase {
  final UserRepository _repository;

  const GetUserByIdUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(int id) =>
      _repository.getUserById(id);
}
