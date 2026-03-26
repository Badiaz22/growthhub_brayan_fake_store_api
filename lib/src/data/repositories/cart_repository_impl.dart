import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/data/datasources/cart_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/models/cart_product_model.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementación concreta de [CartRepository].
///
/// Delega todo el trabajo HTTP a [CartRemoteDatasource] y expone
/// entidades de dominio tipadas al resto de la aplicación.
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource _datasource;

  const CartRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<CartEntity>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) => _datasource.getCarts(
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
  }) => _datasource.getCartsByUser(
    userId,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  ) => _datasource.createCart(
    userId,
    products
        .map(
          (p) => CartProductModel(productId: p.productId, quantity: p.quantity),
        )
        .toList(),
  );

  @override
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) => _datasource.updateCart(
    id,
    userId,
    products
        .map(
          (p) => CartProductModel(productId: p.productId, quantity: p.quantity),
        )
        .toList(),
  );

  @override
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) => _datasource.patchCart(
    id,
    userId,
    products
        .map(
          (p) => CartProductModel(productId: p.productId, quantity: p.quantity),
        )
        .toList(),
  );

  @override
  Future<Either<Failure, CartEntity>> deleteCart(int id) =>
      _datasource.deleteCart(id);
}
