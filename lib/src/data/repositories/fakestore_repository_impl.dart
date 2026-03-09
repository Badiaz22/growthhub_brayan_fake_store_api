import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/data/datasources/fakestore_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/models/cart_product_model.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementación concreta de [FakestoreRepository].
///
/// Delega todo el trabajo HTTP a [FakestoreRemoteDatasource] y expone
/// entidades de dominio tipadas al resto de la aplicación.
class FakestoreRepositoryImpl implements FakestoreRepository {
  final FakestoreRemoteDatasource _datasource;

  const FakestoreRepositoryImpl(this._datasource);

  // ─── Productos ────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  }) =>
      _datasource.getProducts(limit: limit, sort: sort);

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
  }) =>
      _datasource.getProductsByCategory(category, limit: limit, sort: sort);

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
    Map<String, dynamic> productData,
  ) =>
      _datasource.createProduct(productData);

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  ) =>
      _datasource.updateProduct(id, productData);

  @override
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  ) =>
      _datasource.patchProduct(id, productData);

  @override
  Future<Either<Failure, ProductEntity>> deleteProduct(int id) =>
      _datasource.deleteProduct(id);

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({int? limit, String? sort}) =>
      _datasource.getUsers(limit: limit, sort: sort);

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) =>
      _datasource.getUserById(id);

  @override
  Future<Either<Failure, UserEntity>> createUser(Map<String, dynamic> userData) =>
      _datasource.createUser(userData);

  @override
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  ) =>
      _datasource.updateUser(id, userData);

  @override
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  ) =>
      _datasource.patchUser(id, userData);

  @override
  Future<Either<Failure, UserEntity>> deleteUser(int id) =>
      _datasource.deleteUser(id);

  // ─── Carritos ─────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<CartEntity>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) =>
      _datasource.getCarts(
        limit: limit,
        sort: sort,
        startDate: startDate,
        endDate: endDate,
      );

  @override
  Future<Either<Failure, CartEntity>> getCartById(int id) =>
      _datasource.getCartById(id);

  @override
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  }) =>
      _datasource.getCartsByUser(
        userId,
        startDate: startDate,
        endDate: endDate,
      );

  @override
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  ) =>
      _datasource.createCart(
        userId,
        products
            .map(
              (p) =>
                  CartProductModel(productId: p.productId, quantity: p.quantity),
            )
            .toList(),
      );

  @override
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) =>
      _datasource.updateCart(
        id,
        userId,
        products
            .map(
              (p) =>
                  CartProductModel(productId: p.productId, quantity: p.quantity),
            )
            .toList(),
      );

  @override
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) =>
      _datasource.patchCart(
        id,
        userId,
        products
            .map(
              (p) =>
                  CartProductModel(productId: p.productId, quantity: p.quantity),
            )
            .toList(),
      );

  @override
  Future<Either<Failure, CartEntity>> deleteCart(int id) =>
      _datasource.deleteCart(id);

  // ─── Autenticación ────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  ) =>
      _datasource.login(username, password);
}
