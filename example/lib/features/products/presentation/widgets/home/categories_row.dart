/// Fila horizontal de chips de categorías para filtrar productos.
library;

import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import 'category_chip.dart';

/// Sección horizontal desplazable que muestra las categorías disponibles como
/// chips de filtrado.
///
/// Siempre incluye el chip "All" (valor `null`) al inicio. Al seleccionar
/// una categoría invoca [onSelected] con el nombre de la categoría; al
/// presionar "View All" invoca [onSelected] con `null`.
///
/// La lógica de filtrado real está en [filteredProductsProvider]; este widget
/// es puramente visual y delega las acciones al padre mediante callbacks.
///
/// Ejemplo de uso en [HomeScreen]:
/// ```dart
/// CategoriesRow(
///   categories: categories,
///   selectedCategory: selectedCategory,
///   onSelected: (cat) =>
///       ref.read(selectedCategoryProvider.notifier).state = cat,
/// )
/// ```
class CategoriesRow extends StatelessWidget {
  /// Lista de categorías obtenidas de la API.
  final List<CategoryEntity> categories;

  /// Nombre de la categoría actualmente seleccionada. `null` indica "All".
  final String? selectedCategory;

  /// Callback invocado cuando el usuario selecciona una categoría o "View All".
  final ValueChanged<String?> onSelected;

  /// Crea la fila de categorías.
  const CategoriesRow({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CATEGORIES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: Color(0xFF94A3B8),
                ),
              ),
              GestureDetector(
                onTap: () => onSelected(null),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              // Chip especial "All" siempre presente al inicio
              CategoryChip(
                label: 'All',
                isSelected: selectedCategory == null,
                onTap: () => onSelected(null),
              ),
              const SizedBox(width: 8),
              ...categories.map(
                (cat) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CategoryChip(
                    label: cat.name,
                    isSelected: selectedCategory == cat.name,
                    onTap: () => onSelected(cat.name),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
