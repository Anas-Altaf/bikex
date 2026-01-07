import 'dart:async';

import 'package:bikex/auth/auth.dart';
import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/bikes/view/product_detail_page.dart';
import 'package:bikex/checkout/checkout.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/home/home.dart';
import 'package:flutter/cupertino.dart';
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

/// iOS-style slide transition page
CustomTransitionPage<T> _buildSlideTransition<T>({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    barrierColor: AppTheme.backgroundColor,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // iOS-style slide from right
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: Curves.easeInOutCubic),
      );
      final offsetAnimation = animation.drive(tween);

      // Slight scale and fade on the outgoing page
      final secondaryTween = Tween(
        begin: Offset.zero,
        end: const Offset(-0.25, 0.0),
      ).chain(CurveTween(curve: Curves.easeInOutCubic));
      final secondaryOffset = secondaryAnimation.drive(secondaryTween);

      return SlideTransition(
        position: offsetAnimation,
        child: SlideTransition(
          position: secondaryOffset,
          child: child,
        ),
      );
    },
  );
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
      pageBuilder: (context, state) => _buildSlideTransition(
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signup,
      name: 'signup',
      pageBuilder: (context, state) => _buildSlideTransition(
        key: state.pageKey,
        child: const SignupPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      pageBuilder: (context, state) => _buildSlideTransition(
        key: state.pageKey,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      name: 'productDetail',
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId']!;
        return _buildSlideTransition(
          key: state.pageKey,
          child: ProductDetailPage(productId: productId),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.checkout,
      name: 'checkout',
      pageBuilder: (context, state) => _buildSlideTransition(
        key: state.pageKey,
        child: const CheckoutPage(),
      ),
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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(radius: 16),
            SizedBox(height: 16),
            Text(
              'BikeX',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
