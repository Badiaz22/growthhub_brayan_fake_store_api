/// Tarjeta de producto para la grilla de la pantalla principal.
library;

import 'package:brayan_fake_store_api/brayan_fake_store_api.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'add_cart_button.dart';

/// Tarjeta visual para mostrar un [ProductEntity] en la grilla de productos.
///
/// Estructura interna de la tarjeta (de arriba a abajo):
/// 1. Imagen del producto con fondo crema y indicador de carga progresivo.
/// 2. Etiqueta de categoría en color primario.
/// 3. Título truncado a una línea.
/// 4. Fila con el precio y el [AddCartButton].
///
/// El parámetro [onTap] es opcional; si se proporciona, envuelve la tarjeta
/// en un [GestureDetector] para navegar al detalle del producto.
///
/// Ejemplo de uso en un [SliverGrid]:
/// ```dart
/// ProductCard(
///   product: products[index],
///   onTap: () => Navigator.push(...),
/// )
/// ```
class ProductCard extends StatelessWidget {
  /// Producto cuyos datos se muestran en la tarjeta.
  final ProductEntity product;

  /// Callback ejecutado al tocar la tarjeta. Normalmente navega al detalle.
  ///
  /// Si es `null`, la tarjeta no responde a toques.
  final VoidCallback? onTap;

  /// Crea una tarjeta para el [product] dado.
  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPrimary.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de imagen con fondo y carga progresiva
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFF1F0EF),
                padding: const EdgeInsets.all(16),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 40,
                  ),
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: kPrimary,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Sección de información: categoría, título, precio y carrito
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: kPrimary,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E1E1E),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      AddCartButton(productTitle: product.title),
                    ],
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
