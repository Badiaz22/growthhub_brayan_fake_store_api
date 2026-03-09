import 'package:brayan_fake_store_api/src/domain/entities/cart_product_entity.dart';

/// Modelo de datos para [CartProductEntity] — agrega serialización JSON.
class CartProductModel extends CartProductEntity {
  const CartProductModel({required super.productId, required super.quantity});

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        // La API retorna a veces "productId" y otras veces "id".
        productId: (json['productId'] ?? json['id']) as int,
        quantity: json['quantity'] as int,
      );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}
