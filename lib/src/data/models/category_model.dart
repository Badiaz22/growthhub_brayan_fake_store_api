import 'package:brayan_fake_store_api/src/domain/entities/category_entity.dart';

/// Modelo de datos para [CategoryEntity] — agrega serialización JSON.
///
/// La API retorna las categorías como cadenas de texto simples,
/// por lo que [fromJson] acepta un [String].
class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.name});

  factory CategoryModel.fromJson(String name) => CategoryModel(name: name);

  String toJson() => name;
}
