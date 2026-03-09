import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: elimina un usuario por [id] y retorna el recurso eliminado.
class DeleteUserUseCase {
  final FakestoreRepository _repository;

  const DeleteUserUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(int id) => _repository.deleteUser(id);
}
