import 'package:animate_do/animate_do.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon
          ZoomIn(
            duration: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryUpColor.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long,
                size: 64,
                color: AppTheme.primaryUpColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Title
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 400),
            child: const Text(
              'Your Orders',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Description
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 400),
            child: const Text(
              'Your order history will appear here',
              style: TextStyle(
                color: AppTheme.textDescColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Empty state indicator
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 400),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundSurfaceColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'No orders yet',
                style: TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
