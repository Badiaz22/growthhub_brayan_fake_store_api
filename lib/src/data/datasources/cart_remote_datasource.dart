import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/remote_datasource_helpers.dart';
import 'package:brayan_fake_store_api/src/data/models/cart_model.dart';
import 'package:brayan_fake_store_api/src/data/models/cart_product_model.dart';
import 'package:dartz/dartz.dart';

/// Gestiona las llamadas HTTP relacionadas con carritos de compras.
///
/// Deserializa el JSON en [CartModel] tipados y delega
/// los cambios de estado de la aplicación a la capa superior.
class CartRemoteDatasource {
  final ApiClient _client;

  const CartRemoteDatasource(this._client);

  /// Retorna todos los carritos con filtrado opcional por rango de fechas.
  ///
  /// [startDate] / [endDate] – fechas en formato ISO-8601 (`"2020-01-01"`).
  Future<Either<Failure, List<CartModel>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) async {
    final result = await _client.getList(
      RemoteDatasourceHelpers.buildPath(
        '/carts',
        limit: limit,
        sort: sort,
        extra: {
          if (startDate != null) 'startdate': startDate,
          if (endDate != null) 'enddate': endDate,
        },
      ),
    );
    return result.fold(
      (f) => Left(f),
      (list) => RemoteDatasourceHelpers.parseList(list, CartModel.fromJson),
    );
  }

  /// Retorna un único carrito por su [id].
  Future<Either<Failure, CartModel>> getCartById(int id) async {
    final result = await _client.getMap('/carts/$id');
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, CartModel.fromJson),
    );
  }

  /// Retorna todos los carritos pertenecientes a [userId].
  Future<Either<Failure, List<CartModel>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  }) async {
    final result = await _client.getList(
      RemoteDatasourceHelpers.buildPath(
        '/carts/user/$userId',
        extra: {
          if (startDate != null) 'startdate': startDate,
          if (endDate != null) 'enddate': endDate,
        },
      ),
    );
    return result.fold(
      (f) => Left(f),
      (list) => RemoteDatasourceHelpers.parseList(list, CartModel.fromJson),
    );
  }

  /// Crea un nuevo carrito. Retorna el recurso con su id asignado.
  Future<Either<Failure, CartModel>> createCart(
    int userId,
    List<CartProductModel> products,
  ) async {
    final body = {
      'userId': userId,
      'products': products.map((p) => p.toJson()).toList(),
    };
    final result = await _client.post('/carts', body);
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, CartModel.fromJson),
    );
  }

  /// Reemplaza un carrito completo (actualización PUT).
  Future<Either<Failure, CartModel>> updateCart(
    int id,
    int userId,
    List<CartProductModel> products,
  ) async {
    final body = {
      'userId': userId,
      'products': products.map((p) => p.toJson()).toList(),
    };
    final result = await _client.put('/carts/$id', body);
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, CartModel.fromJson),
    );
  }

  /// Actualiza parcialmente un carrito (PATCH).
  Future<Either<Failure, CartModel>> patchCart(
    int id,
    int userId,
    List<CartProductModel> products,
  ) async {
    final body = {
      'userId': userId,
      'products': products.map((p) => p.toJson()).toList(),
    };
    final result = await _client.patch('/carts/$id', body);
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, CartModel.fromJson),
    );
  }

  /// Elimina un carrito y retorna el recurso eliminado.
  Future<Either<Failure, CartModel>> deleteCart(int id) async {
    final result = await _client.delete('/carts/$id');
    return result.fold(
      (f) => Left(f),
      (json) => RemoteDatasourceHelpers.parseObject(json, CartModel.fromJson),
    );
  }
}
