import 'package:bikex/cart/models/cart_item.dart';
import 'package:equatable/equatable.dart';

/// Order status enum
enum OrderStatus {
  processing('Processing'),
  shipped('Shipped'),
  outForDelivery('Out for Delivery'),
  delivered('Delivered')
  ;

  const OrderStatus(this.displayName);
  final String displayName;
}

/// Order model representing a completed purchase
class Order extends Equatable {
  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDelivery,
  });

  /// Unique order ID
  final String id;

  /// List of items in the order
  final List<CartItem> items;

  /// Total order amount
  final double total;

  /// Current order status
  final OrderStatus status;

  /// When the order was placed
  final DateTime createdAt;

  /// Estimated delivery date
  final DateTime? estimatedDelivery;

  /// Total number of items
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Copy with new status
  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? total,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? estimatedDelivery,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
    );
  }

  @override
  List<Object?> get props => [
    id,
    items,
    total,
    status,
    createdAt,
    estimatedDelivery,
  ];
}
