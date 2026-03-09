import 'package:brayan_fake_store_api/src/data/models/rating_model.dart';
import 'package:brayan_fake_store_api/src/domain/entities/product_entity.dart';

/// Modelo de datos para [ProductEntity] — agrega serialización JSON.
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    category: json['category'] as String,
    image: json['image'] as String,
    rating: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'category': category,
    'image': image,
    'rating': {'rate': rating.rate, 'count': rating.count},
  };
}
