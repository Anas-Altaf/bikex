import 'package:asra_ai/all_chats/all_chats.dart';
import 'package:asra_ai/auth/auth.dart';
import 'package:asra_ai/chat/chat.dart';
import 'package:asra_ai/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.authRepo,
    required this.chatRepo,
    super.key,
  });

  final AuthRepo authRepo;
  final ChatRepo chatRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider.value(value: chatRepo),
      ],
      child: BlocProvider(
        create: (_) => AuthCubit(authRepo: authRepo),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return switch (state) {
            AuthUnknown() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            AuthAuthenticated(:final user) => AllChatsPage(
              userId: user.id,
              username: user.name,
            ),
            AuthUnauthenticated() => const LoginPage(),
            AuthError(:final message) => Scaffold(
              body: Center(child: Text('Error: $message')),
            ),
          };
        },
      ),
    );
  }
}
