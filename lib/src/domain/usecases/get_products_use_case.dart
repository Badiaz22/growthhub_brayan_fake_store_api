import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Caso de uso: obtiene el catálogo completo de productos
/// con paginación y ordenamiento opcionales.
class GetProductsUseCase {
  final FakestoreRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<Either<Failure, List<ProductEntity>>> call({int? limit, String? sort}) =>
      _repository.getProducts(limit: limit, sort: sort);
}
