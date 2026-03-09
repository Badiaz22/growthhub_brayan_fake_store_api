import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: crea un nuevo carrito y lo retorna con su [id] asignado.
class CreateCartUseCase {
  final FakestoreRepository _repository;

  const CreateCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(
    int userId,
    List<CartProductEntity> products,
  ) =>
      _repository.createCart(userId, products);
}
