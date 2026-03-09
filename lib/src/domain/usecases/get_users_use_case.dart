import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene todos los usuarios registrados.
class GetUsersUseCase {
  final FakestoreRepository _repository;

  const GetUsersUseCase(this._repository);

  Future<Either<Failure, List<UserEntity>>> call({int? limit, String? sort}) =>
      _repository.getUsers(limit: limit, sort: sort);
}
