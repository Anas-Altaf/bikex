import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      builder: (context, state) {
        return Stack(
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

            // Tab items
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_icons.length, (index) {
                  final isActive = state.currentIndex == index;

                  return _TabItem(
                    icon: _icons[index],
                    label: _labels[index],
                    isActive: isActive,
                    onTap: () {
                      context.read<NavigationCubit>().changeTab(index);
                    },
                  );
                }),
              ),
            ),
          ],
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
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

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
            child: Column(
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
          ),
        ),
      ),
    );
  }
}
