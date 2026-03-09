import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene todos los carritos con filtros opcionales.
class GetCartsUseCase {
  final FakestoreRepository _repository;

  const GetCartsUseCase(this._repository);

  Future<Either<Failure, List<CartEntity>>> call({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) =>
      _repository.getCarts(
        limit: limit,
        sort: sort,
        startDate: startDate,
        endDate: endDate,
      );
}
