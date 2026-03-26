import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: crea un nuevo usuario y lo retorna con su [id] asignado.
class CreateUserUseCase {
  final UserRepository _repository;

  const CreateUserUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(Map<String, dynamic> userData) =>
      _repository.createUser(userData);
}
