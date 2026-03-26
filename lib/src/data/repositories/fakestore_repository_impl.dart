import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/auth_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/cart_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/fakestore_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/product_repository.dart';
import 'package:brayan_fake_store_api/src/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementación composita de [FakestoreRepository].
///
/// Delega todas las operaciones a repositorios específicos por dominio:
/// - Productos → [ProductRepository]
/// - Usuarios → [UserRepository]
/// - Carritos → [CartRepository]
/// - Autenticación → [AuthRepository]
class FakestoreRepositoryImpl implements FakestoreRepository {
  final ProductRepository _productRepository;
  final UserRepository _userRepository;
  final CartRepository _cartRepository;
  final AuthRepository _authRepository;

  /// Constructor composita que recibe todos los repositorios específicos.
  FakestoreRepositoryImpl.composite({
    required ProductRepository productRepository,
    required UserRepository userRepository,
    required CartRepository cartRepository,
    required AuthRepository authRepository,
  }) : _productRepository = productRepository,
       _userRepository = userRepository,
       _cartRepository = cartRepository,
       _authRepository = authRepository;

  // ─── Productos ────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  }) => _productRepository.getProducts(limit: limit, sort: sort);

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) =>
      _productRepository.getProductById(id);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() =>
      _productRepository.getCategories();

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) => _productRepository.getProductsByCategory(
    category,
    limit: limit,
    sort: sort,
  );

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
    Map<String, dynamic> productData,
  ) => _productRepository.createProduct(productData);

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  ) => _productRepository.updateProduct(id, productData);

  @override
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  ) => _productRepository.patchProduct(id, productData);

  @override
  Future<Either<Failure, ProductEntity>> deleteProduct(int id) =>
      _productRepository.deleteProduct(id);

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({
    int? limit,
    String? sort,
  }) => _userRepository.getUsers(limit: limit, sort: sort);

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) =>
      _userRepository.getUserById(id);

  @override
  Future<Either<Failure, UserEntity>> createUser(
    Map<String, dynamic> userData,
  ) => _userRepository.createUser(userData);

  @override
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  ) => _userRepository.updateUser(id, userData);

  @override
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  ) => _userRepository.patchUser(id, userData);

  @override
  Future<Either<Failure, UserEntity>> deleteUser(int id) =>
      _userRepository.deleteUser(id);

  // ─── Carritos ─────────────────────────────────────────────────────────────

  @override
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

  @override
  Future<Either<Failure, CartEntity>> getCartById(int id) =>
      _cartRepository.getCartById(id);

  @override
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  }) => _cartRepository.getCartsByUser(
    userId,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  ) => _cartRepository.createCart(userId, products);

  @override
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) => _cartRepository.updateCart(id, userId, products);

  @override
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  ) => _cartRepository.patchCart(id, userId, products);

  @override
  Future<Either<Failure, CartEntity>> deleteCart(int id) =>
      _cartRepository.deleteCart(id);

  // ─── Autenticación ────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  ) => _authRepository.login(username, password);
}
