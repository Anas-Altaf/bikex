import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/orders/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Card displaying an order with items and status
class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.order,
    super.key,
  });

  final Order order;

  Color _getStatusColor(OrderStatus status) {
    return switch (status) {
      OrderStatus.processing => Colors.orange,
      OrderStatus.shipped => Colors.blue,
      OrderStatus.outForDelivery => Colors.purple,
      OrderStatus.delivered => Colors.green,
    };
  }

  IconData _getStatusIcon(OrderStatus status) {
    return switch (status) {
      OrderStatus.processing => Icons.hourglass_empty,
      OrderStatus.shipped => Icons.local_shipping,
      OrderStatus.outForDelivery => Icons.delivery_dining,
      OrderStatus.delivered => Icons.check_circle,
    };
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final statusColor = _getStatusColor(order.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cartCardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor01,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order header with ID and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.id,
                style: const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(order.status),
                      color: statusColor,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      order.status.displayName,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Order date
          Text(
            'Ordered: ${dateFormat.format(order.createdAt)}',
            style: const TextStyle(
              color: AppTheme.textDescColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),

          // Order items
          ...order.items
              .take(3)
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      // Product image
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundSurfaceColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.product.images.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Product info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                color: AppTheme.textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Qty: ${item.quantity}',
                              style: const TextStyle(
                                color: AppTheme.textDescColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Item total
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppTheme.primaryUpColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

          // Show "and X more items" if there are more than 3
          if (order.items.length > 3)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '... and ${order.items.length - 3} more item(s)',
                style: const TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          const Divider(color: AppTheme.borderColor01, height: 24),

          // Order total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${order.itemCount} item(s)',
                style: const TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 13,
                ),
              ),
              Text(
                'Total: \$${order.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
