import 'package:asra_ai/app/app.dart';
import 'package:asra_ai/auth/auth.dart';
import 'package:asra_ai/bootstrap.dart';
import 'package:asra_ai/chat/chat.dart';

Future<void> main() async {
  await bootstrap(() {
    final authRepo = AuthRepo();
    final chatRepo = ChatRepo();

    return App(
      authRepo: authRepo,
      chatRepo: chatRepo,
    );
  });
}
