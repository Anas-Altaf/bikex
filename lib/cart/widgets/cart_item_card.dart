import 'package:bikex/cart/models/models.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Card widget displaying a cart item with quantity controls
class CartItemCard extends StatelessWidget {
  const CartItemCard({
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final CartItem cartItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Product image
          Container(
            alignment: .center,
            width: 100,
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: AppTheme.cartCardGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ClipRRect(
                child: Image.asset(
                  cartItem.product.images.isNotEmpty
                      ? cartItem.product.images.first
                      : 'assets/images/cycle_01.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name.toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 30),
                Text(
                  '\$ ${cartItem.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppTheme.primaryUpColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls
          _QuantityControls(
            quantity: cartItem.quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}

/// Quantity increment/decrement controls
class _QuantityControls extends StatelessWidget {
  const _QuantityControls({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:AppTheme.boxDecoration01,
      padding:const .all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Increment button
          _ControlButton(
            icon: Icons.add,
            onTap: onIncrement,
            isIncrement: true,
          ),
          // Quantity display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: AppTheme.textColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Decrement button
          _ControlButton(
            icon: Icons.remove,
            onTap: onDecrement,
            isIncrement: false,
          ),
        ],
      ),
    );
  }
}

/// Individual control button (+ or -)
class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.onTap,
    required this.isIncrement,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isIncrement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          gradient: isIncrement ? AppTheme.primaryGradient2 : null,
          color: isIncrement ? null : AppTheme.backgroundSurfaceColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: isIncrement ? Colors.white : AppTheme.textDescColor,
          size: 24,
        ),
      ),
    );
  }
}
