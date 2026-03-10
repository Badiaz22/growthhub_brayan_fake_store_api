/// Repositorio de la capa de datos para la feature de productos.
///
/// Actúa como adaptador entre el paquete [brayan_fake_store_api] —que usa
/// el tipo funcional `Either<Failure, T>`— y la capa de presentación, que
/// trabaja con el [AsyncValue] de Riverpod.
library;

import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';

/// Repositorio que expone operaciones de productos como [Future]s simples.
///
/// Convierte los resultados `Either<Failure, T>` del paquete en excepciones
/// de Dart estándar para que Riverpod los capture automáticamente en el
/// estado de error del [AsyncValue].
///
/// Ejemplo de uso en un provider:
/// ```dart
/// final productsProvider = FutureProvider<List<ProductEntity>>((ref) {
///   return ref.read(productsRepositoryProvider).getProducts();
/// });
/// ```
class ProductsRepository {
  final BrayanFakeStoreApi _api;

  /// Crea el repositorio con una instancia del API.
  ///
  /// El parámetro [api] es opcional para facilitar la inyección de un mock
  /// en pruebas unitarias.
  ProductsRepository({BrayanFakeStoreApi? api})
      : _api = api ?? BrayanFakeStoreApi();

  /// Obtiene el listado completo de productos.
  ///
  /// Lanza una [Exception] con el mensaje de error si la llamada falla.
  Future<List<ProductEntity>> getProducts() async {
    final result = await _api.getProducts();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }

  /// Obtiene los productos que pertenecen a la [category] indicada.
  ///
  /// Lanza una [Exception] con el mensaje de error si la llamada falla.
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    final result = await _api.getProductsByCategory(category);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }

  /// Obtiene un único producto por su [id].
  ///
  /// Lanza una [Exception] con el mensaje de error si la llamada falla.
  Future<ProductEntity> getProductById(int id) async {
    final result = await _api.getProductById(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (product) => product,
    );
  }

  /// Obtiene el listado de categorías disponibles en la Fake Store API.
  ///
  /// Lanza una [Exception] con el mensaje de error si la llamada falla.
  Future<List<CategoryEntity>> getCategories() async {
    final result = await _api.getCategories();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (categories) => categories,
    );
  }
}
