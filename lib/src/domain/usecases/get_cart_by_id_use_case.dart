import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene un único carrito por su [id] numérico.
class GetCartByIdUseCase {
  final FakestoreRepository _repository;

  const GetCartByIdUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(int id) => _repository.getCartById(id);
}
