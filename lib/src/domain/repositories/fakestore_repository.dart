import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/auth_response_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

/// Contrato que define todas las operaciones expuestas por el paquete.
///
/// La capa de datos provee una implementación concreta; la capa de dominio
/// y los casos de uso dependen únicamente de esta interfaz
/// (Principio de Inversión de Dependencias).
abstract interface class FakestoreRepository {
  // ─── Productos ────────────────────────────────────────────────────────────

  /// Retorna todos los productos, con paginación y ordenamiento opcionales.
  ///
  /// [limit] – cantidad máxima de resultados (por defecto la API retorna todos).
  /// [sort]  – `"asc"` (predeterminado) o `"desc"`.
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  });

  /// Retorna un único producto por su [id].
  Future<Either<Failure, ProductEntity>> getProductById(int id);

  /// Retorna todas las categorías de productos disponibles.
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  /// Retorna los productos que pertenecen a [category].
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  });

  /// Crea un nuevo producto. Retorna el recurso con su id asignado.
  Future<Either<Failure, ProductEntity>> createProduct(
    Map<String, dynamic> productData,
  );

  /// Reemplaza un producto completo (actualización PUT).
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  );

  /// Actualiza parcialmente un producto (PATCH).
  Future<Either<Failure, ProductEntity>> patchProduct(
    int id,
    Map<String, dynamic> productData,
  );

  /// Elimina un producto y retorna el recurso eliminado.
  Future<Either<Failure, ProductEntity>> deleteProduct(int id);

  // ─── Usuarios ─────────────────────────────────────────────────────────────

  /// Retorna todos los usuarios, con paginación y ordenamiento opcionales.
  Future<Either<Failure, List<UserEntity>>> getUsers({int? limit, String? sort});

  /// Retorna un único usuario por su [id].
  Future<Either<Failure, UserEntity>> getUserById(int id);

  /// Crea un nuevo usuario. Retorna el recurso con su id asignado.
  Future<Either<Failure, UserEntity>> createUser(Map<String, dynamic> userData);

  /// Reemplaza un usuario completo (actualización PUT).
  Future<Either<Failure, UserEntity>> updateUser(
    int id,
    Map<String, dynamic> userData,
  );

  /// Actualiza parcialmente un usuario (PATCH).
  Future<Either<Failure, UserEntity>> patchUser(
    int id,
    Map<String, dynamic> userData,
  );

  /// Elimina un usuario y retorna el recurso eliminado.
  Future<Either<Failure, UserEntity>> deleteUser(int id);

  // ─── Carritos ─────────────────────────────────────────────────────────────

  /// Retorna todos los carritos con filtrado opcional por rango de fechas.
  ///
  /// [startDate] / [endDate] – fechas en formato ISO-8601 (`"2020-01-01"`).
  Future<Either<Failure, List<CartEntity>>> getCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  });

  /// Retorna un único carrito por su [id].
  Future<Either<Failure, CartEntity>> getCartById(int id);

  /// Retorna todos los carritos pertenecientes a [userId].
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    String? startDate,
    String? endDate,
  });

  /// Crea un nuevo carrito. Retorna el recurso con su id asignado.
  Future<Either<Failure, CartEntity>> createCart(
    int userId,
    List<CartProductEntity> products,
  );

  /// Reemplaza un carrito completo (actualización PUT).
  Future<Either<Failure, CartEntity>> updateCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  );

  /// Actualiza parcialmente un carrito (PATCH).
  Future<Either<Failure, CartEntity>> patchCart(
    int id,
    int userId,
    List<CartProductEntity> products,
  );

  /// Elimina un carrito y retorna el recurso eliminado.
  Future<Either<Failure, CartEntity>> deleteCart(int id);

  // ─── Autenticación ────────────────────────────────────────────────────────

  /// Autentica un usuario y retorna un token JWT.
  Future<Either<Failure, AuthResponseEntity>> login(
    String username,
    String password,
  );
}
