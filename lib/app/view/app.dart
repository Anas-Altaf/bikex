import 'package:bikex/auth/auth.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/l10n/l10n.dart';
import 'package:bikex/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.authRepo,
    super.key,
  });

  final AuthRepo authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepo,
      child: BlocProvider(
        create: (_) => AuthCubit(authRepo: authRepo),
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.backgroundColor),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.router,
    );
  }
}
