/// Encabezado de sección reutilizable con título y contador opcional.
library;

import 'package:flutter/material.dart';

/// Encabezado de sección que muestra un [title] prominente y, opcionalmente,
/// un [count] de resultados alineado a la derecha.
///
/// El contador solo se renderiza cuando [count] no es `null`, lo que permite
/// usarlo antes de que los datos estén disponibles sin mostrar un "0 items".
///
/// Ejemplo de uso:
/// ```dart
/// SectionHeader(
///   title: 'Trending Products',
///   count: products.length, // null mientras carga
/// )
/// ```
class SectionHeader extends StatelessWidget {
  /// Texto principal del encabezado de sección.
  final String title;

  /// Número de ítems encontrados que se muestra a la derecha.
  ///
  /// Si es `null`, el contador no se renderiza.
  final int? count;

  /// Crea el encabezado de sección con el [title] requerido.
  const SectionHeader({super.key, required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          if (count != null)
            Text(
              '$count items found',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF94A3B8),
              ),
            ),
        ],
      ),
    );
  }
}
