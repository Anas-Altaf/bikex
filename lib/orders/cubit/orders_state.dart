part of 'orders_cubit.dart';

/// State for orders
class OrdersState extends Equatable {
  const OrdersState({
    this.orders = const [],
  });

  /// List of all orders
  final List<Order> orders;

  /// Whether there are any orders
  bool get isEmpty => orders.isEmpty;

  /// Total number of orders
  int get orderCount => orders.length;

  /// Number of pending (non-delivered) orders
  int get pendingCount =>
      orders.where((o) => o.status != OrderStatus.delivered).length;

  OrdersState copyWith({
    List<Order>? orders,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [orders];
}
