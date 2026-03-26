import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/data/datasources/product_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementación concreta de [ProductRepository].
///
/// Delega todo el trabajo HTTP a [ProductRemoteDatasource] y expone
/// entidades de dominio tipadas al resto de la aplicación.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource _datasource;

  const ProductRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  }) => _datasource.getProducts(limit: limit, sort: sort);

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) =>
      _datasource.getProductById(id);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() =>
      _datasource.getCategories();

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) => _datasource.getProductsByCategory(category, limit: limit, sort: sort);

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
    Map<String, dynamic> productData,
  ) => _datasource.createProduct(productData);

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  ) => _datasource.updateProduct(id, productData);

  @override
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  ) => _datasource.patchProduct(id, productData);

  @override
  Future<Either<Failure, ProductEntity>> deleteProduct(int id) =>
      _datasource.deleteProduct(id);
}
