import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/core/network/api_client.dart';
import 'package:brayan_fake_store_api/src/data/datasources/auth_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/datasources/cart_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/datasources/product_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/datasources/user_remote_datasource.dart';
import 'package:brayan_fake_store_api/src/data/repositories/auth_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/cart_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/product_repository_impl.dart';
import 'package:brayan_fake_store_api/src/data/repositories/user_repository_impl.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/auth_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/cart_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/product_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/user_repository.dart';
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
  final ProductRepository _productRepository;
  final UserRepository _userRepository;
  final CartRepository _cartRepository;
  final AuthRepository _authRepository;

  /// Crea una instancia que configura el stack HTTP automáticamente.
  ///
  /// [httpClient] – cliente personalizado opcional (útil para pruebas).
  BrayanFakeStoreApi({http.Client? httpClient})
    : _productRepository = _buildProductRepository(httpClient),
      _userRepository = _buildUserRepository(httpClient),
      _cartRepository = _buildCartRepository(httpClient),
      _authRepository = _buildAuthRepository(httpClient);

  /// Crea una instancia con repositorios preconfigurados (para pruebas).
  BrayanFakeStoreApi.withRepositories({
    required ProductRepository productRepository,
    required UserRepository userRepository,
    required CartRepository cartRepository,
    required AuthRepository authRepository,
  }) : _productRepository = productRepository,
       _userRepository = userRepository,
       _cartRepository = cartRepository,
       _authRepository = authRepository;

  static ProductRepository _buildProductRepository(http.Client? client) {
    final apiClient = ApiClient(client: client);
    final datasource = ProductRemoteDatasource(apiClient);
    return ProductRepositoryImpl(datasource);
  }

  static UserRepository _buildUserRepository(http.Client? client) {
    final apiClient = ApiClient(client: client);
    final datasource = UserRemoteDatasource(apiClient);
    return UserRepositoryImpl(datasource);
  }

  static CartRepository _buildCartRepository(http.Client? client) {
    final apiClient = ApiClient(client: client);
    final datasource = CartRemoteDatasource(apiClient);
    return CartRepositoryImpl(datasource);
  }

  static AuthRepository _buildAuthRepository(http.Client? client) {
    final apiClient = ApiClient(client: client);
    final datasource = AuthRemoteDatasource(apiClient);
    return AuthRepositoryImpl(datasource);
  }

  // ─── Productos ────────────────────────────────────────────────────────────

  /// Obtiene todos los productos.
  ///
  /// [limit] – limita la cantidad de resultados (por defecto la API retorna todos).
  /// [sort]  – `"asc"` (predeterminado) o `"desc"`.
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  }) => _productRepository.getProducts(limit: limit, sort: sort);

  /// Obtiene un único producto por su [id].
  Future<Either<Failure, ProductEntity>> getProductById(int id) =>
      _productRepository.getProductById(id);

  /// Obtiene todas las categorías de productos disponibles.
  Future<Either<Failure, List<CategoryEntity>>> getCategories() =>
      _productRepository.getCategories();

  /// Obtiene los productos que pertenecen a [category].
  ///
  /// Usa [getCategories] para obtener los nombres de categoría válidos.
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) => _productRepository.getProductsByCategory(
    category,
    limit: limit,
    sort: sort,
  );

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
  ) => _productRepository.createProduct(productData);

  /// Reemplaza un producto completo (actualización PUT). Retorna el recurso actualizado.
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  ) => _productRepository.updateProduct(id, productData);

  /// Actualiza parcialmente un producto (PATCH). Retorna el recurso actualizado.
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  ) => _productRepository.patchProduct(id, productData);

  /// Elimina un producto por [id]. Retorna el recurso eliminado.
  Future<Either<Failure, ProductEntity>> deleteProduct(int id) =>
      _productRepository.deleteProduct(id);

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  /// Obtiene todos los usuarios.
  Future<Either<Failure, List<UserEntity>>> getUsers({
    int? limit,
    String? sort,
  }) => _userRepository.getUsers(limit: limit, sort: sort);

  /// Obtiene un único usuario por su [id].
  Future<Either<Failure, UserEntity>> getUserById(int id) =>
      _userRepository.getUserById(id);

  /// Crea un nuevo usuario. Retorna el recurso con su id asignado.
  Future<Either<Failure, UserEntity>> createUser(
    Map<String, dynamic> userData,
  ) => _userRepository.createUser(userData);

  /// Reemplaza un usuario completo (actualización PUT). Retorna el recurso actualizado.
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  ) => _userRepository.updateUser(id, userData);

  /// Actualiza parcialmente un usuario (PATCH). Retorna el recurso actualizado.
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  ) => _userRepository.patchUser(id, userData);

  /// Elimina un usuario por [id]. Retorna el recurso eliminado.
  Future<Either<Failure, UserEntity>> deleteUser(int id) =>
      _userRepository.deleteUser(id);

  // ─── Carritos ─────────────────────────────────────────────────────────────

  /// Obtiene todos los carritos con filtrado opcional por rango de fechas.
  ///
  /// [startDate] / [endDate] aceptan cadenas de fecha en formato ISO-8601 (`"2020-01-01"`).
  Future<Either<Failure, List<CartEntity>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) => _cartRepository.getCarts(
    limit: limit,
    sort: sort,
    startDate: startDate,
    endDate: endDate,
  );

  /// Obtiene un único carrito por su [id].
  Future<Either<Failure, CartEntity>> getCartById(int id) =>
      _cartRepository.getCartById(id);

  /// Obtiene todos los carritos pertenecientes a [userId].
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  }) => _cartRepository.getCartsByUser(
    userId,
    startDate: startDate,
    endDate: endDate,
  );

  /// Crea un nuevo carrito para [userId] con los [products] indicados.
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  ) => _cartRepository.createCart(userId, products);

  /// Reemplaza un carrito completo (actualización PUT). Retorna el recurso actualizado.
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) => _cartRepository.updateCart(id, userId, products);

  /// Actualiza parcialmente un carrito (PATCH). Retorna el recurso actualizado.
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) => _cartRepository.patchCart(id, userId, products);

  /// Elimina un carrito por [id]. Retorna el recurso eliminado.
  Future<Either<Failure, CartEntity>> deleteCart(int id) =>
      _cartRepository.deleteCart(id);

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
  ) => _authRepository.login(username, password);
}
