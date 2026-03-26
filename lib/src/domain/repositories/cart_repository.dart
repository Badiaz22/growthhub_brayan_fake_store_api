import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';
import 'package:dartz/dartz.dart';

/// Contrato que define todas las operaciones de carritos expuestas por el paquete.
///
/// La capa de datos provee una implementación concreta; la capa de dominio
/// y los casos de uso dependen únicamente de esta interfaz
/// (Principio de Inversión de Dependencias).
abstract interface class CartRepository {
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
}
