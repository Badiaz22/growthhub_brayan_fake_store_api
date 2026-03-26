import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';

/// Contrato principal que define todas las operaciones disponibles en Fake Store API.
///
/// Combina bajo un único contrato todas las operaciones de:
/// - Productos
/// - Usuarios
/// - Carritos
/// - Autenticación
///
/// De este modo, los consumidores del paquete ([BrayanFakeStoreApi.buildRepository])
/// solo necesitan depender de esta interfaz estable, sin acoplarse a
/// implementaciones concretas.
abstract interface class FakestoreRepository {
  // ─── Productos ────────────────────────────────────────────────────────────

  /// Obtiene todos los productos.
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  });

  /// Obtiene un producto por su ID.
  Future<Either<Failure, ProductEntity>> getProductById(int id);

  /// Obtiene el listado de categorías disponibles.
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  /// Obtiene todos los productos de una categoría específica.
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  });

  /// Crea un producto nuevo.
  Future<Either<Failure, ProductEntity>> createProduct(
    Map<String, dynamic> productData,
  );

  /// Actualiza completamente un producto existente.
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  );

  /// Actualiza parcialmente un producto.
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  );

  /// Elimina un producto.
  Future<Either<Failure, ProductEntity>> deleteProduct(int id);

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  /// Obtiene todos los usuarios.
  Future<Either<Failure, List<UserEntity>>> getUsers({
    int? limit,
    String? sort,
  });

  /// Obtiene un usuario por su ID.
  Future<Either<Failure, UserEntity>> getUserById(int id);

  /// Crea un usuario nuevo.
  Future<Either<Failure, UserEntity>> createUser(Map<String, dynamic> userData);

  /// Actualiza completamente un usuario existente.
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  );

  /// Actualiza parcialmente un usuario.
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  );

  /// Elimina un usuario.
  Future<Either<Failure, UserEntity>> deleteUser(int id);

  // ─── Carritos ─────────────────────────────────────────────────────────────

  /// Obtiene todos los carritos.
  Future<Either<Failure, List<CartEntity>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  });

  /// Obtiene un carrito por su ID.
  Future<Either<Failure, CartEntity>> getCartById(int id);

  /// Obtiene todos los carritos de un usuario específico.
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  });

  /// Crea un carrito nuevo.
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  );

  /// Actualiza completamente un carrito existente.
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  );

  /// Actualiza parcialmente un carrito.
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  );

  /// Elimina un carrito.
  Future<Either<Failure, CartEntity>> deleteCart(int id);

  // ─── Autenticación ────────────────────────────────────────────────────────

  /// Realiza login con usuario y contraseña. Retorna datos y token JWT.
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  );
}
