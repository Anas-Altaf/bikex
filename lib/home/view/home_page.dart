import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/cart/cart.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/primary_icon_btn.dart';
import 'package:bikex/map/map.dart';
import 'package:bikex/navigation/navigation.dart';
import 'package:bikex/orders/orders.dart';
import 'package:bikex/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Widget> _screens = [
    BikesPage(),
    MapPage(),
    CartPage(),
    ProfilePage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                color: AppTheme.backgroundColor,
              ),
              Container(
                transform: Matrix4.translationValues(0, 110, 0),
                child: SvgPicture.asset(
                  'assets/bg/background_shape.svg',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Scaffold(
                backgroundColor: AppTheme.transparentColor,
                appBar: appBar(),
                body: SafeArea(
                  top: false,
                  child: Stack(
                    children: [
                      _screens[state.currentIndex],
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: BottomTabBar(),
                      ),
                    ],
                  ),
                ),
                // bottomNavigationBar: const BottomTabBar(),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Choose Your Bike',
        style: TextStyle(
          color: AppTheme.textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Padding(
          padding: .only(right: 14),
          child: PrimaryIconBtn(
            assetName: 'assets/icons/search.svg',
            gradient: AppTheme.primaryGradient,
            onTap: () {
              //TODO: Implement search functionality
            },
          ),
        ),
      ],
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
    );
  }
}
