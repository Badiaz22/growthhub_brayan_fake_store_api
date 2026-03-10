/// Chip de categoría con estado de selección animado.
library;

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

/// Chip de filtrado que representa una categoría de productos.
///
/// Cambia su apariencia mediante una animación suave cuando [isSelected]
/// alterna entre `true` y `false`:
/// - **Seleccionado**: fondo [kPrimary], texto blanco, sombra de color.
/// - **No seleccionado**: fondo blanco, texto gris oscuro, borde sutil.
///
/// Se usa dentro de [CategoriesRow] como ítem del listado horizontal.
///
/// Ejemplo de uso:
/// ```dart
/// CategoryChip(
///   label: 'Electronics',
///   isSelected: selectedCategory == 'electronics',
///   onTap: () => onSelected('electronics'),
/// )
/// ```
class CategoryChip extends StatelessWidget {
  /// Texto que se muestra en el chip (se transforma a mayúsculas).
  final String label;

  /// Indica si este chip está actualmente seleccionado.
  final bool isSelected;

  /// Callback invocado al tocar el chip.
  final VoidCallback onTap;

  /// Crea el chip para la categoría con el [label] dado.
  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? kPrimary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? kPrimary : kPrimary.withValues(alpha: 0.15),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: kPrimary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}
