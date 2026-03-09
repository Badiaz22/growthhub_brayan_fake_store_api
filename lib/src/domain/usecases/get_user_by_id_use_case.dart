import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene un único usuario por su [id] numérico.
class GetUserByIdUseCase {
  final FakestoreRepository _repository;

  const GetUserByIdUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(int id) => _repository.getUserById(id);
}
