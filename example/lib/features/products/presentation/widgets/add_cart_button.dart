/// Botón compacto de "agregar al carrito".
library;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Botón icónico de 32×32 que simula la acción de agregar un producto al
/// carrito mostrando un [SnackBar] de confirmación.
///
/// Se usa dentro de [ProductCard] en la esquina inferior derecha de la tarjeta.
/// El [productTitle] se incluye en el mensaje de confirmación para que el
/// usuario sepa qué producto fue agregado.
///
/// Ejemplo de uso:
/// ```dart
/// AddCartButton(productTitle: product.title)
/// ```
class AddCartButton extends StatelessWidget {
  /// Nombre del producto que aparecerá en el [SnackBar] de confirmación.
  final String productTitle;

  /// Crea el botón de carrito para el producto con el [productTitle] dado.
  const AddCartButton({super.key, required this.productTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$productTitle added to cart'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      ),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: kPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.add_shopping_cart_outlined,
          size: 17,
          color: kPrimary,
        ),
      ),
    );
  }
}
