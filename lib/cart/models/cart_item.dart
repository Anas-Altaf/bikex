import 'package:bikex/bikes/models/product.dart';
import 'package:equatable/equatable.dart';

/// Represents an item in the shopping cart
class CartItem extends Equatable {
  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  final Product product;
  final int quantity;

  /// Total price for this cart item (price × quantity)
  double get totalPrice => product.price * quantity;

  /// Create a copy with updated values
  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
