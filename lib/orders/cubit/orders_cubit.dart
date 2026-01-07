import 'dart:math';

import 'package:bikex/cart/models/cart_item.dart';
import 'package:bikex/orders/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

/// Cubit for managing orders
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());

  final _random = Random();

  /// Add a new order from cart items
  void addOrder({
    required List<CartItem> items,
    required double total,
  }) {
    // Generate random order ID
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

    // Assign random status (for demo purposes)
    final statuses = OrderStatus.values;
    final randomStatus = statuses[_random.nextInt(statuses.length)];

    // Create estimated delivery date (3-7 days from now)
    final daysToAdd = 3 + _random.nextInt(5);
    final estimatedDelivery = DateTime.now().add(Duration(days: daysToAdd));

    final order = Order(
      id: orderId,
      items: List.from(items), // Copy items
      total: total,
      status: randomStatus,
      createdAt: DateTime.now(),
      estimatedDelivery: estimatedDelivery,
    );

    emit(
      state.copyWith(
        orders: [order, ...state.orders], // Add new order at the top
      ),
    );
  }

  /// Get count of non-delivered orders
  int get pendingOrdersCount {
    return state.orders
        .where((order) => order.status != OrderStatus.delivered)
        .length;
  }

  /// Update order status
  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final updatedOrders = state.orders.map((order) {
      if (order.id == orderId) {
        return order.copyWith(status: newStatus);
      }
      return order;
    }).toList();

    emit(state.copyWith(orders: updatedOrders));
  }
}
