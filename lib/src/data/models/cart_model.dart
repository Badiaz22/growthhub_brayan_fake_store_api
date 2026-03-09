import 'package:brayan_fake_store_api/src/data/models/cart_product_model.dart';
import 'package:brayan_fake_store_api/src/domain/entities/cart_entity.dart';

/// Modelo de datos para [CartEntity] — agrega serialización JSON.
class CartModel extends CartEntity {
  const CartModel({
    required super.id,
    required super.userId,
    required super.date,
    required super.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] as int,
    userId: json['userId'] as int,
    date: DateTime.parse(json['date'] as String),
    products:
        (json['products'] as List<dynamic>)
            .map((p) => CartProductModel.fromJson(p as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'date': date.toIso8601String(),
    'products':
        products
            .map((p) => {'productId': p.productId, 'quantity': p.quantity})
            .toList(),
  };
}
