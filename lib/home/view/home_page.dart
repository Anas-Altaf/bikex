import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/cart/cart.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/types/enums.dart';
import 'package:bikex/core/widgets/diagonal_gradient_painter.dart';
import 'package:bikex/core/widgets/widgets.dart';
import 'package:bikex/map/map.dart';
import 'package:bikex/navigation/navigation.dart';
import 'package:bikex/orders/orders.dart';
import 'package:bikex/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Index of the cart tab
const int _cartTabIndex = 2;

/// Index of the bikes tab (shows diagonal gradient background)
const int _bikesTabIndex = 0;

/// Height of the bottom tab bar for animation
const double _tabBarHeight = 100;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Widget> _screens = [
    BikesPage(),
    MapPage(),
    CartPage(),
    ProfilePage(),
    OrdersPage(),
  ];

  static const List<String> _titles = [
    'Choose Your Bike',
    'Find Nearby',
    'My Shopping Cart',
    'Profile',
    'Your Orders',
  ];

  @override
  Widget build(BuildContext context) {
    // Navigation cubit is local to home page
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, navState) {
          final isCartTab = navState.currentIndex == _cartTabIndex;
          final isBikesTab = navState.currentIndex == _bikesTabIndex;

          return Stack(
            children: [
              // Base background color
              Container(color: AppTheme.backgroundColor),

              // Diagonal gradient background - only on Bikes tab
              if (isBikesTab)
                Positioned.fill(
                  child: CustomPaint(
                    painter: DiagonalGradientPainter(),
                  ),
                ),

              Scaffold(
                backgroundColor: AppTheme.transparentColor,
                appBar: CustomAppBar(
                  title: _titles[navState.currentIndex],
                  iconType: isCartTab
                      ? AppBarIconType.back
                      : AppBarIconType.search,
                  onTap: isCartTab
                      ? () {
                          // Go back to bikes tab (index 0)
                          context.read<NavigationCubit>().changeTab(0);
                        }
                      : null,
                ),
                body: SafeArea(
                  top: false,
                  child: Stack(
                    children: [
                      // Add bottom padding when tab bar is visible
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: isCartTab ? 0 : _tabBarHeight - 30,
                        ),
                        child: _screens[navState.currentIndex],
                      ),

                      // Animated bottom tab bar
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        left: 0,
                        right: 0,
                        bottom: isCartTab ? -_tabBarHeight : 0,
                        child: const BottomTabBar(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
