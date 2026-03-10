/// Pantalla principal de la aplicación.
///
/// Muestra el catálogo de productos con filtrado por categoría.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/products_provider.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/home/app_header.dart';
import '../widgets/home/categories_row.dart';
import '../widgets/home/section_header.dart';
import '../widgets/home/store_search_bar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/product_card.dart';

/// Pantalla de inicio que presenta el catálogo de productos en una grilla
/// de dos columnas con filtrado reactivo por categoría.
///
/// Observa tres providers:
/// - [filteredProductsProvider]: lista de productos (con o sin filtro).
/// - [categoriesProvider]: categorías para los chips de filtrado.
/// - [selectedCategoryProvider]: categoría actualmente seleccionada.
///
class HomeScreen extends ConsumerWidget {
  /// Crea la pantalla principal.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(filteredProductsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Cabecera fija: logo y acciones
            const AppHeader(),
            const SizedBox(height: 4),
            // Barra de búsqueda fija
            const StoreSearchBar(),
            const SizedBox(height: 8),
            // Contenido desplazable: categorías + grilla de productos
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Chips de categorías (se ocultan mientras cargan)
                  SliverToBoxAdapter(
                    child: categoriesAsync.when(
                      loading: () => const SizedBox(height: 52),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (categories) => CategoriesRow(
                        categories: categories,
                        selectedCategory: selectedCategory,
                        onSelected: (category) => ref
                            .read(selectedCategoryProvider.notifier)
                            .state = category,
                      ),
                    ),
                  ),
                  // Título de sección con contador de resultados
                  SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'Trending Products',
                      count: productsAsync.value?.length,
                    ),
                  ),
                  // Grilla de productos con manejo de estados
                  productsAsync.when(
                    loading: () => const SliverFillRemaining(
                      child: LoadingWidget(message: 'Loading products...'),
                    ),
                    error: (error, _) => SliverFillRemaining(
                      child: AppErrorWidget(
                        message:
                            error.toString().replaceFirst('Exception: ', ''),
                        onRetry: () => ref.invalidate(filteredProductsProvider),
                      ),
                    ),
                    data: (products) => SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ProductCard(
                            product: products[index],
                            onTap: null,
                          ),
                          childCount: products.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
