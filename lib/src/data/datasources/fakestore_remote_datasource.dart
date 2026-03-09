import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/models/auth_response_model.dart';
import 'package:brayan_fake_store_api/src/data/models/cart_model.dart';
import 'package:brayan_fake_store_api/src/data/models/cart_product_model.dart';
import 'package:brayan_fake_store_api/src/data/models/category_model.dart';
import 'package:brayan_fake_store_api/src/data/models/product_model.dart';
import 'package:brayan_fake_store_api/src/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

/// Gestiona todas las llamadas HTTP y deserializa el JSON en modelos tipados.
///
/// Es la única clase que interactúa directamente con [ApiClient].
class FakestoreRemoteDatasource {
  final ApiClient _client;

  const FakestoreRemoteDatasource(this._client);

  // ─── Productos ────────────────────────────────────────────────────────────

  Future<Either<Failure, List<ProductModel>>> getProducts({
    int? limit,
    String? sort,
  }) async {
    final result = await _client.getList(
      _path('/products', limit: limit, sort: sort),
    );
    return result.fold(
      (f) => Left(f),
      (list) => _parseList(list, ProductModel.fromJson),
    );
  }

  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    final result = await _client.getMap('/products/$id');
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, ProductModel.fromJson),
    );
  }

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    final result = await _client.getList('/products/categories');
    return result.fold(
      (f) => Left(f),
      (list) {
        try {
          return Right(list.cast<String>().map(CategoryModel.fromJson).toList());
        } catch (e) {
          return Left(ParsingFailure(e.toString()));
        }
      },
    );
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) async {
    final result = await _client.getList(
      _path('/products/category/$category', limit: limit, sort: sort),
    );
    return result.fold(
      (f) => Left(f),
      (list) => _parseList(list, ProductModel.fromJson),
    );
  }

  Future<Either<Failure, ProductModel>> createProduct(
    Map<String, dynamic> data,
  ) async {
    final result = await _client.post('/products', data);
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, ProductModel.fromJson),
    );
  }

  Future<Either<Failure, ProductModel>> updateProduct(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.put('/products/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, ProductModel.fromJson),
    );
  }

  Future<Either<Failure, ProductModel>> patchProduct(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.patch('/products/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, ProductModel.fromJson),
    );
  }

  Future<Either<Failure, ProductModel>> deleteProduct(int id) async {
    final result = await _client.delete('/products/$id');
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, ProductModel.fromJson),
    );
  }

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  Future<Either<Failure, List<UserModel>>> getUsers({
    int? limit,
    String? sort,
  }) async {
    final result = await _client.getList(
      _path('/users', limit: limit, sort: sort),
    );
    return result.fold(
      (f) => Left(f),
      (list) => _parseList(list, UserModel.fromJson),
    );
  }

  Future<Either<Failure, UserModel>> getUserById(int id) async {
    final result = await _client.getMap('/users/$id');
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, UserModel.fromJson),
    );
  }

  Future<Either<Failure, UserModel>> createUser(
    Map<String, dynamic> data,
  ) async {
    final result = await _client.post('/users', data);
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, UserModel.fromJson),
    );
  }

  Future<Either<Failure, UserModel>> updateUser(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.put('/users/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, UserModel.fromJson),
    );
  }

  Future<Either<Failure, UserModel>> patchUser(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.patch('/users/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, UserModel.fromJson),
    );
  }

  Future<Either<Failure, UserModel>> deleteUser(int id) async {
    final result = await _client.delete('/users/$id');
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, UserModel.fromJson),
    );
  }

  // ─── Carritos ─────────────────────────────────────────────────────────────

  Future<Either<Failure, List<CartModel>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) async {
    final result = await _client.getList(
      _path(
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
      (list) => _parseList(list, CartModel.fromJson),
    );
  }

  Future<Either<Failure, CartModel>> getCartById(int id) async {
    final result = await _client.getMap('/carts/$id');
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, CartModel.fromJson),
    );
  }

  Future<Either<Failure, List<CartModel>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  }) async {
    final result = await _client.getList(
      _path(
        '/carts/user/$userId',
        extra: {
          if (startDate != null) 'startdate': startDate,
          if (endDate != null) 'enddate': endDate,
        },
      ),
    );
    return result.fold(
      (f) => Left(f),
      (list) => _parseList(list, CartModel.fromJson),
    );
  }

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
      (json) => _parseObject(json, CartModel.fromJson),
    );
  }

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
      (json) => _parseObject(json, CartModel.fromJson),
    );
  }

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
      (json) => _parseObject(json, CartModel.fromJson),
    );
  }

  Future<Either<Failure, CartModel>> deleteCart(int id) async {
    final result = await _client.delete('/carts/$id');
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, CartModel.fromJson),
    );
  }

  // ─── Autenticación ────────────────────────────────────────────────────────

  Future<Either<Failure, AuthResponseModel>> login(
    String username,
    String password,
  ) async {
    final result = await _client.post('/auth/login', {
      'username': username,
      'password': password,
    });
    return result.fold(
      (f) => Left(f),
      (json) => _parseObject(json, AuthResponseModel.fromJson),
    );
  }

  // ─── Métodos privados de soporte ──────────────────────────────────────────

  /// Construye la ruta con parámetros de consulta opcionales.
  String _path(
    String base, {
    int? limit,
    String? sort,
    Map<String, String>? extra,
  }) {
    final params = <String, String>{
      if (limit != null) 'limit': '$limit',
      if (sort != null) 'sort': sort,
      ...?extra,
    };
    if (params.isEmpty) return base;
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$base?$query';
  }

  Either<Failure, List<T>> _parseList<T>(
    List<dynamic> list,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      return Right(list.cast<Map<String, dynamic>>().map(fromJson).toList());
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }

  Either<Failure, T> _parseObject<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      return Right(fromJson(json));
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }
}
