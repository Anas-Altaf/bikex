import 'package:bikex/auth/auth.dart';
import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/cart/cart.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/l10n/l10n.dart';
import 'package:bikex/orders/orders.dart';
import 'package:bikex/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({
    required this.authRepo,
    super.key,
  });

  final AuthRepo authRepo;

  @override
  Widget build(BuildContext context) {
    // Create repositories at app level (concrete implementations)
    final ProductsRepo productsRepo = MockProductsRepo();
    final FavoritesRepo favoritesRepo = InMemoryFavoritesRepo();
    final CartRepo cartRepo = MockCartRepo();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider<ProductsRepo>.value(value: productsRepo),
        RepositoryProvider<FavoritesRepo>.value(value: favoritesRepo),
        RepositoryProvider<CartRepo>.value(value: cartRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(authRepo: authRepo)),
          BlocProvider(
            create: (_) =>
                ProductsCubit(productsRepo: productsRepo)..loadProducts(),
          ),
          BlocProvider(
            create: (_) => FavoritesCubit(favoritesRepo: favoritesRepo),
          ),
          BlocProvider(
            create: (_) => CartCubit(cartRepo: cartRepo),
          ),
          BlocProvider(
            create: (_) => OrdersCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final AppRouter _appRouter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appRouter = AppRouter(authCubit: context.read<AuthCubit>());
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: const ToastificationConfig(
        alignment: Alignment.topCenter,
        maxDescriptionLines: 0,
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.backgroundColor,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
