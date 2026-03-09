import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: elimina un carrito por [id] y retorna el recurso eliminado.
class DeleteCartUseCase {
  final FakestoreRepository _repository;

  const DeleteCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(int id) => _repository.deleteCart(id);
}
