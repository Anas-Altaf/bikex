import 'dart:async';

import 'package:bikex/auth/auth.dart';
import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/bikes/view/product_detail_page.dart';
import 'package:bikex/checkout/checkout.dart';
import 'package:bikex/examples/test.dart';
import 'package:bikex/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application route paths
abstract class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String productDetail = '/product/:productId';
  static const String checkout = '/checkout';

  /// Helper to build product detail path
  static String productDetailPath(String productId) => '/product/$productId';

  static const String test =
      '/test'; // keeping it for later use for testing screens
}

/// Application router configuration
class AppRouter {
  AppRouter({required this.authCubit});

  final AuthCubit authCubit;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: _redirect,
    routes: _routes,
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = authCubit.state;
    final isOnAuthPage =
        state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.signup;
    final isOnSplash = state.matchedLocation == AppRoutes.splash;

    return switch (authState) {
      // Still loading auth state
      AuthUnknown() => isOnSplash ? null : AppRoutes.splash,

      // Not authenticated - redirect to login
      AuthUnauthenticated() ||
      AuthError() => isOnAuthPage ? null : AppRoutes.login,

      // Authenticated - redirect away from auth pages
      AuthAuthenticated() =>
        (isOnAuthPage || isOnSplash) ? AppRoutes.home : null,
    };
  }

  List<RouteBase> get _routes => [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      name: 'signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      name: 'productDetail',
      builder: (context, state) {
        final productId = state.pathParameters['productId']!;
        return ProductDetailPage(productId: productId);
      },
    ),
    GoRoute(
      path: AppRoutes.checkout,
      name: 'checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
  ];
}

/// Helper class to convert Stream to Listenable for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}

/// Splash page shown during auth state loading
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('BikeX'),
          ],
        ),
      ),
    );
  }
}
