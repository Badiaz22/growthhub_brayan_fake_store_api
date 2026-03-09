import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene todos los productos que pertenecen a una [category].
class GetProductsByCategoryUseCase {
  final FakestoreRepository _repository;

  const GetProductsByCategoryUseCase(this._repository);

  Future<Either<Failure, List<ProductEntity>>> call(
    String category, {
    int? limit,
    String? sort,
  }) =>
      _repository.getProductsByCategory(category, limit: limit, sort: sort);
}
