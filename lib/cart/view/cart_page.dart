import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 64,
            color: AppTheme.primaryUpColor,
          ),
          SizedBox(height: 16),
          Text(
            'Cart',
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your shopping cart',
            style: TextStyle(
              color: AppTheme.textDescColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
