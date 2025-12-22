import 'package:asra_ai/all_chats/all_chats.dart';
import 'package:asra_ai/auth/auth.dart';
import 'package:asra_ai/l10n/gen/app_localizations.dart';
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
          AuthAuthenticated(user: final user) => AllChatsPage(
            userId: user.id,
            username: user.email,
          ),
          AuthUnauthenticated() => const Scaffold(
            body: Center(child: Text('Please sign in.')),
          ),
          AuthError(message: final message) => Scaffold(
            body: Center(child: Text('Error: $message')),
          ),
        },
      ),
    );
  }
}
