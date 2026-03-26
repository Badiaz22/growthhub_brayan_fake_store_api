import 'package:brayan_fake_store_api/src/core/errors/failure.dart';
import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

/// Contrato que define todas las operaciones de productos expuestas por el paquete.
///
/// La capa de datos provee una implementación concreta; la capa de dominio
/// y los casos de uso dependen únicamente de esta interfaz
/// (Principio de Inversión de Dependencias).
abstract interface class ProductRepository {
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
}
