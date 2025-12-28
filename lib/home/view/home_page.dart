import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/cart/cart.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/widgets.dart';
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

  static const List<String> _titles = [
    'Choose Your Bike',
    'Find Nearby',
    'Your Cart',
    'Profile',
    'Your Orders',
  ];

  @override
  Widget build(BuildContext context) {
    // Create repos
    final productsRepo = ProductsRepo();
    final favoritesRepo = FavoritesRepo();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: productsRepo),
        RepositoryProvider.value(value: favoritesRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NavigationCubit()),
          BlocProvider(
            create: (_) =>
                ProductsCubit(productsRepo: productsRepo)..loadProducts(),
          ),
          BlocProvider(
            create: (_) => FavoritesCubit(favoritesRepo: favoritesRepo),
          ),
        ],
        child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, navState) {
            return Stack(
              children: [
                Container(color: AppTheme.backgroundColor),
                Container(
                  transform: Matrix4.translationValues(0, 75, 0),
                  child: SvgPicture.asset(
                    'assets/bg/background_shape.svg',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Scaffold(
                  backgroundColor: AppTheme.transparentColor,
                  appBar: CustomAppBar(
                    title: _titles[navState.currentIndex],
                    rightIcon: navState.currentIndex == 0
                        ? PrimaryIconBtn(
                            assetName: 'assets/icons/search.svg',
                            gradient: AppTheme.primaryGradient,
                            onTap: () {
                              // TODO(dev): Implement search.
                            },
                          )
                        : null,
                  ),
                  body: SafeArea(
                    top: false,
                    child: Stack(
                      children: [
                        _screens[navState.currentIndex],
                        const Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: BottomTabBar(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
