import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/remote_datasource_helpers.dart';
import 'package:brayan_fake_store_api/src/data/models/category_model.dart';
import 'package:brayan_fake_store_api/src/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

/// Gestiona las llamadas HTTP relacionadas con productos.
///
/// Deserializa el JSON en [ProductModel] tipados y delega
/// los cambios de estado de la aplicación a la capa superior.
class ProductRemoteDatasource {
  final ApiClient _client;

  const ProductRemoteDatasource(this._client);

  /// Retorna todos los productos, con paginación y ordenamiento opcionales.
  ///
  /// [limit] – cantidad máxima de resultados (por defecto la API retorna todos).
  /// [sort]  – `"asc"` (predeterminado) o `"desc"`.
  Future<Either<Failure, List<ProductModel>>> getProducts({
    int? limit,
    String? sort,
  }) async {
    final result = await _client.getList(
      RemoteDatasourceHelpers.buildPath('/products', limit: limit, sort: sort),
    );
    return result.fold(
      (f) => Left(f),
      (list) => RemoteDatasourceHelpers.parseList(list, ProductModel.fromJson),
    );
  }

  /// Retorna un único producto por su [id].
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    final result = await _client.getMap('/products/$id');
    return result.fold(
      (f) => Left(f),
      (json) =>
          RemoteDatasourceHelpers.parseObject(json, ProductModel.fromJson),
    );
  }

  /// Retorna todas las categorías de productos disponibles.
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    final result = await _client.getList('/products/categories');
    return result.fold((f) => Left(f), (list) {
      try {
        return Right(list.cast<String>().map(CategoryModel.fromJson).toList());
      } catch (e) {
        return Left(ParsingFailure(e.toString()));
      }
    });
  }

  /// Retorna los productos que pertenecen a [category].
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) async {
    final result = await _client.getList(
      RemoteDatasourceHelpers.buildPath(
        '/products/category/$category',
        limit: limit,
        sort: sort,
      ),
    );
    return result.fold(
      (f) => Left(f),
      (list) => RemoteDatasourceHelpers.parseList(list, ProductModel.fromJson),
    );
  }

  /// Crea un nuevo producto. Retorna el recurso con su id asignado.
  Future<Either<Failure, ProductModel>> createProduct(
    Map<String, dynamic> data,
  ) async {
    final result = await _client.post('/products', data);
    return result.fold(
      (f) => Left(f),
      (json) =>
          RemoteDatasourceHelpers.parseObject(json, ProductModel.fromJson),
    );
  }

  /// Reemplaza un producto completo (actualización PUT).
  Future<Either<Failure, ProductModel>> updateProduct(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.put('/products/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) =>
          RemoteDatasourceHelpers.parseObject(json, ProductModel.fromJson),
    );
  }

  /// Actualiza parcialmente un producto (PATCH).
  Future<Either<Failure, ProductModel>> patchProduct(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.patch('/products/$id', data);
    return result.fold(
      (f) => Left(f),
      (json) =>
          RemoteDatasourceHelpers.parseObject(json, ProductModel.fromJson),
    );
  }

  /// Elimina un producto y retorna el recurso eliminado.
  Future<Either<Failure, ProductModel>> deleteProduct(int id) async {
    final result = await _client.delete('/products/$id');
    return result.fold(
      (f) => Left(f),
      (json) =>
          RemoteDatasourceHelpers.parseObject(json, ProductModel.fromJson),
    );
  }
}
