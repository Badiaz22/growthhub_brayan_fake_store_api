import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/fakestore_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/repositories/fakestore_repository_impl.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// Punto de entrada principal del paquete Brayan Fake Store API.
///
/// ### Inicio rápido
/// ```dart
/// final api = BrayanFakeStoreApi();
///
/// final resultado = await api.getProducts(limit: 10, sort: 'desc');
/// resultado.fold(
///   (falla) => print('Error: ${falla.message}'),
///   (productos) => print('Se obtuvieron ${productos.length} productos'),
/// );
/// ```
///
/// ### Inyección de dependencias / pruebas
/// Pasa un [http.Client] personalizado (p. ej. un mock) para evitar
/// llamadas reales a la red:
/// ```dart
/// final api = BrayanFakeStoreApi(httpClient: MockHttpClient());
/// ```
class BrayanFakeStoreApi {
  final FakestoreRepository _repository;

  /// Crea una instancia que configura el stack HTTP automáticamente.
  ///
  /// [httpClient] – cliente personalizado opcional (útil para pruebas).
  BrayanFakeStoreApi({http.Client? httpClient})
    : _repository = _buildRepository(httpClient);

  /// Crea una instancia con un [FakestoreRepository] preconfigurado (para pruebas).
  BrayanFakeStoreApi.withRepository(FakestoreRepository repository)
    : _repository = repository;

  static FakestoreRepository _buildRepository(http.Client? client) {
    final apiClient = ApiClient(client: client);
    final datasource = FakestoreRemoteDatasource(apiClient);
    return FakestoreRepositoryImpl(datasource);
  }

  // ─── Productos ────────────────────────────────────────────────────────────

  /// Obtiene todos los productos.
  ///
  /// [limit] – limita la cantidad de resultados (por defecto la API retorna todos).
  /// [sort]  – `"asc"` (predeterminado) o `"desc"`.
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  }) =>
      _repository.getProducts(limit: limit, sort: sort);

  /// Obtiene un único producto por su [id].
  Future<Either<Failure, ProductEntity>> getProductById(int id) =>
      _repository.getProductById(id);

  /// Obtiene todas las categorías de productos disponibles.
  Future<Either<Failure, List<CategoryEntity>>> getCategories() =>
      _repository.getCategories();

  /// Obtiene los productos que pertenecen a [category].
  ///
  /// Usa [getCategories] para obtener los nombres de categoría válidos.
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) =>
      _repository.getProductsByCategory(category, limit: limit, sort: sort);

  /// Crea un nuevo producto. Retorna el recurso con su id asignado.
  ///
  /// Ejemplo de [productData]:
  /// ```dart
  /// {
  ///   'title': 'Mi producto',
  ///   'price': 29.99,
  ///   'description': 'Un gran producto',
  ///   'category': "men's clothing",
  ///   'image': 'https://example.com/img.png',
  /// }
  /// ```
  Future<Either<Failure, ProductEntity>> createProduct(
    Map<String, dynamic> productData,
  ) =>
      _repository.createProduct(productData);

  /// Reemplaza un producto completo (actualización PUT). Retorna el recurso actualizado.
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  ) =>
      _repository.updateProduct(id, productData);

  /// Actualiza parcialmente un producto (PATCH). Retorna el recurso actualizado.
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  ) =>
      _repository.patchProduct(id, productData);

  /// Elimina un producto por [id]. Retorna el recurso eliminado.
  Future<Either<Failure, ProductEntity>> deleteProduct(int id) =>
      _repository.deleteProduct(id);

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  /// Obtiene todos los usuarios.
  Future<Either<Failure, List<UserEntity>>> getUsers({int? limit, String? sort}) =>
      _repository.getUsers(limit: limit, sort: sort);

  /// Obtiene un único usuario por su [id].
  Future<Either<Failure, UserEntity>> getUserById(int id) =>
      _repository.getUserById(id);

  /// Crea un nuevo usuario. Retorna el recurso con su id asignado.
  Future<Either<Failure, UserEntity>> createUser(Map<String, dynamic> userData) =>
      _repository.createUser(userData);

  /// Reemplaza un usuario completo (actualización PUT). Retorna el recurso actualizado.
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  ) =>
      _repository.updateUser(id, userData);

  /// Actualiza parcialmente un usuario (PATCH). Retorna el recurso actualizado.
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  ) =>
      _repository.patchUser(id, userData);

  /// Elimina un usuario por [id]. Retorna el recurso eliminado.
  Future<Either<Failure, UserEntity>> deleteUser(int id) =>
      _repository.deleteUser(id);

  // ─── Carritos ─────────────────────────────────────────────────────────────

  /// Obtiene todos los carritos con filtrado opcional por rango de fechas.
  ///
  /// [startDate] / [endDate] aceptan cadenas de fecha en formato ISO-8601 (`"2020-01-01"`).
  Future<Either<Failure, List<CartEntity>>> getCarts({
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

  /// Obtiene un único carrito por su [id].
  Future<Either<Failure, CartEntity>> getCartById(int id) =>
      _repository.getCartById(id);

  /// Obtiene todos los carritos pertenecientes a [userId].
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  }) =>
      _repository.getCartsByUser(
        userId,
        startDate: startDate,
        endDate: endDate,
      );

  /// Crea un nuevo carrito para [userId] con los [products] indicados.
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  ) =>
      _repository.createCart(userId, products);

  /// Reemplaza un carrito completo (actualización PUT). Retorna el recurso actualizado.
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) =>
      _repository.updateCart(id, userId, products);

  /// Actualiza parcialmente un carrito (PATCH). Retorna el recurso actualizado.
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) =>
      _repository.patchCart(id, userId, products);

  /// Elimina un carrito por [id]. Retorna el recurso eliminado.
  Future<Either<Failure, CartEntity>> deleteCart(int id) =>
      _repository.deleteCart(id);

  // ─── Autenticación ────────────────────────────────────────────────────────

  /// Autentica un usuario y retorna un token JWT en caso de éxito.
  ///
  /// Ejemplo:
  /// ```dart
  /// final resultado = await api.login('johnd', 'm38rmF\$');
  /// resultado.fold(
  ///   (f) => print('Login fallido: \${f.message}'),
  ///   (auth) => print('Token: \${auth.token}'),
  /// );
  /// ```
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  ) =>
      _repository.login(username, password);
}
