import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene todos los carritos pertenecientes a un [userId] específico.
class GetCartsByUserUseCase {
  final FakestoreRepository _repository;

  const GetCartsByUserUseCase(this._repository);

  Future<Either<Failure, List<CartEntity>>> call(
    int userId, {
    String? startDate,
    String? endDate,
  }) =>
      _repository.getCartsByUser(
        userId,
        startDate: startDate,
        endDate: endDate,
      );
}
