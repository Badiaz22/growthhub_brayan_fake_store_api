import 'rating_entity.dart';

/// Producto disponible en el catálogo de la Fake Store.
class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;

  /// Nombre de la categoría (ej. `"electronics"`, `"jewelery"`).
  final String category;

  /// URL pública de la imagen del producto.
  final String image;

  final RatingEntity rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
  });
}
