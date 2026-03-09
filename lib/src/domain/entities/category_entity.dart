/// Categoría de productos disponible en la Fake Store.
class CategoryEntity {
  /// Etiqueta de la categoría retornada por la API (ej. `"electronics"`).
  final String name;

  const CategoryEntity({required this.name});

  @override
  String toString() => name;
}
