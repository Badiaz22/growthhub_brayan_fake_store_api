import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: reemplaza un carrito completo (PUT). Retorna el recurso actualizado.
class UpdateCartUseCase {
  final FakestoreRepository _repository;

  const UpdateCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) =>
      _repository.updateCart(id, userId, products);
}
