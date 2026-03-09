import 'cart_product_entity.dart';

/// Carrito de compras perteneciente a un [UserEntity].
class CartEntity {
  final int id;
  final int userId;

  /// Fecha de creación o última modificación del carrito.
  final DateTime date;

  final List<CartProductEntity> products;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
}
