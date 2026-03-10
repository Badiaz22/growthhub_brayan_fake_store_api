/// Widget reutilizable para mostrar precios con estilo consistente.
library;

import 'package:flutter/material.dart';

/// Etiqueta de precio con fondo redondeado que toma los colores del tema
/// activo.
///
/// Formatea automáticamente el [price] con dos decimales y símbolo `$`.
/// El [fontSize] es configurable para adaptarse a contextos de tamaño
/// diferente (lista vs detalle).
///
/// Ejemplo de uso:
/// ```dart
/// PriceTag(price: 29.99)            // tamaño por defecto (16)
/// PriceTag(price: 99.00, fontSize: 20) // más grande en pantalla de detalle
/// ```
class PriceTag extends StatelessWidget {
  /// Precio a mostrar.
  final double price;

  /// Tamaño de fuente del texto del precio. Por defecto `16`.
  final double fontSize;

  /// Crea la etiqueta de precio para el [price] dado.
  const PriceTag({super.key, required this.price, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '\$${price.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
