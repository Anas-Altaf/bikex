import 'dart:async';

import 'package:bikex/auth/auth.dart';
import 'package:bikex/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application route paths
abstract class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
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

    // Still loading auth state
    if (authState is AuthUnknown) {
      return isOnSplash ? null : AppRoutes.splash;
    }

    // Not authenticated - redirect to login
    if (authState is AuthUnauthenticated || authState is AuthError) {
      return isOnAuthPage ? null : AppRoutes.login;
    }

    // Authenticated - redirect away from auth pages
    if (authState is AuthAuthenticated) {
      if (isOnAuthPage || isOnSplash) {
        return AppRoutes.home;
      }
    }

    return null;
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
