/// Barra de búsqueda de la pantalla principal.
library;

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

/// Campo de búsqueda estilizado fijo bajo la cabecera de la [HomeScreen].
///
/// En esta versión la búsqueda es únicamente visual (UI placeholder).
/// Para conectarla a lógica de filtrado, exponer un [TextEditingController]
/// o un callback `onChanged`.
///
/// Diseño:
/// ```
/// [ 🔍  Search curated collections...          ]
/// ```
class StoreSearchBar extends StatelessWidget {
  /// Crea la barra de búsqueda.
  const StoreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPrimary.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search_rounded, color: kPrimary, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search curated collections...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
