import 'package:animate_do/animate_do.dart';
import 'package:bikex/cart/cart.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/navigation/navigation.dart';
import 'package:bikex/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tab indices
const int _cartTabIndex = 2;
const int _ordersTabIndex = 4;

/// Reusable bottom tab bar widget with skewed design
class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key});

  static const List<IconData> _icons = [
    Icons.pedal_bike,
    Icons.map,
    Icons.shopping_cart,
    Icons.person,
    Icons.description,
  ];

  static const List<String> _labels = [
    'Bikes',
    'Map',
    'Cart',
    'Profile',
    'Orders',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navState) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, ordersState) {
                return FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Skewed gradient background
                      Transform(
                        transform: Matrix4.translationValues(0, 50, 0),
                        child: Container(
                          transform: Matrix4.skewY(-0.06),
                          height: 120,
                          transformAlignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            gradient: AppTheme.tabBarGradient,
                          ),
                        ),
                      ),

                      // Tab items with staggered animation
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(_icons.length, (index) {
                            final isActive = navState.currentIndex == index;

                            // Get badge count for cart and orders
                            int badgeCount = 0;
                            if (index == _cartTabIndex) {
                              badgeCount = cartState.itemCount;
                            } else if (index == _ordersTabIndex) {
                              badgeCount = ordersState.pendingCount;
                            }

                            return FadeInUp(
                              delay: Duration(milliseconds: 100 + (index * 50)),
                              duration: const Duration(milliseconds: 400),
                              child: _TabItem(
                                icon: _icons[index],
                                label: _labels[index],
                                isActive: isActive,
                                badgeCount: badgeCount,
                                onTap: () {
                                  context.read<NavigationCubit>().changeTab(
                                    index,
                                  );
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Transform(
        transform: Matrix4.skewY(-0.15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            0,
            isActive ? -10 : 0,
            0,
          ),
          width: isActive ? 65 : 48,
          height: isActive ? 50 : 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isActive ? AppTheme.primaryGradient : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Transform(
            transform: Matrix4.skewY(0.15),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: isActive ? 28 : 24,
                      color: isActive
                          ? AppTheme.textColor
                          : AppTheme.textColor.withAlpha(150),
                    ),
                  ],
                ),
                // Badge
                if (badgeCount > 0)
                  Positioned(
                    top: isActive ? 2 : 4,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryUpColor.withAlpha(100),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          badgeCount > 9 ? '9+' : '$badgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
