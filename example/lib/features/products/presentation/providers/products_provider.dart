/// Providers de Riverpod para la feature de productos.
///
/// Define la fuente de verdad del estado de la UI: repositorio, categorías,
/// categoría seleccionada y listado filtrado de productos.
library;

import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/products_repository.dart';

/// Provee una única instancia de [ProductsRepository] compartida en toda
/// la aplicación.
///
/// Al ser un [Provider] simple, Riverpod garantiza que se crea solo una vez
/// y se reutiliza mientras el [ProviderScope] esté activo.
final productsRepositoryProvider = Provider<ProductsRepository>(
  (_) => ProductsRepository(),
);

/// Carga el listado completo de productos desde la API.
///
/// Se utiliza internamente por [filteredProductsProvider] cuando no hay
/// ninguna categoría seleccionada. Puede invalidarse con
/// `ref.invalidate(productsProvider)` para refrescar los datos.
final productsProvider = FutureProvider<List<ProductEntity>>((ref) {
  return ref.watch(productsRepositoryProvider).getProducts();
});

/// Carga las categorías disponibles desde la API.
///
/// Las categorías se usan en [CategoriesRow] para renderizar los chips de
/// filtrado. Se resuelve una sola vez y se cachea por Riverpod.
final categoriesProvider = FutureProvider<List<CategoryEntity>>((ref) {
  return ref.watch(productsRepositoryProvider).getCategories();
});

/// Almacena el nombre de la categoría actualmente seleccionada.
///
/// Un valor `null` indica que se muestran todos los productos (sin filtro).
/// Modificar este provider con `ref.read(selectedCategoryProvider.notifier).state`
/// actualiza automáticamente [filteredProductsProvider].
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Provee el listado de productos filtrado según [selectedCategoryProvider].
///
/// - Si [selectedCategoryProvider] es `null`, delega en [productsProvider].
/// - Si hay una categoría seleccionada, llama a `getProductsByCategory`.
///
/// Cualquier cambio en [selectedCategoryProvider] dispara una nueva carga
/// automáticamente gracias al seguimiento reactivo de Riverpod.
final filteredProductsProvider = FutureProvider<List<ProductEntity>>((ref) {
  final repo = ref.watch(productsRepositoryProvider);
  final selected = ref.watch(selectedCategoryProvider);
  if (selected == null) return repo.getProducts();
  return repo.getProductsByCategory(selected);
});

/// Provee un único [ProductEntity] identificado por [id].
///
/// Usa `FutureProvider.family` para que cada id tenga su propia instancia
/// cacheada de forma independiente. El cache se limpia al salir de la
/// pantalla de detalles.
final productDetailProvider =
    FutureProvider.family<ProductEntity, int>((ref, id) {
  return ref.watch(productsRepositoryProvider).getProductById(id);
});
