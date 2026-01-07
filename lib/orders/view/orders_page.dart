import 'package:animate_do/animate_do.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/icon_circle.dart';
import 'package:bikex/orders/cubit/cubit.dart';
import 'package:bikex/orders/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state.isEmpty) {
          return _EmptyOrdersView();
        }

        return CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${state.orderCount} Order(s)',
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Orders list
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final order = state.orders[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: 50 * index),
                    duration: const Duration(milliseconds: 400),
                    child: OrderCard(order: order),
                  );
                },
                childCount: state.orders.length,
              ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon using reusable IconCircle
          const IconCircle(
            icon: Icons.receipt_long,
            useGradient: false,
          ),
          const SizedBox(height: 32),
          // Title
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 400),
            child: const Text(
              'No Orders Yet',
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
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 400),
            child: const Text(
              'Your order history will appear here',
              style: TextStyle(
                color: AppTheme.textDescColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
