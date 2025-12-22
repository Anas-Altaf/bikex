import 'package:bikex/auth/auth.dart';
import 'package:bikex/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => switch (state) {
          AuthUnknown() => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          AuthAuthenticated(user: final user) => Scaffold(
            appBar: AppBar(
              title: Text('Welcome, ${user.name}'),
              actions: [
                IconButton(
                  onPressed: () => context.read<AuthCubit>().signOut(),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: const Center(
              child: Text('BikeX - Coming Soon'),
            ),
          ),
          AuthUnauthenticated() => const LoginPage(),
          AuthError(message: final message) => Scaffold(
            body: Center(child: Text('Error: $message')),
          ),
        },
      ),
    );
  }
}
