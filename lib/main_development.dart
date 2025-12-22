import 'package:bikex/app/app.dart';
import 'package:bikex/auth/auth.dart';
import 'package:bikex/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() {
    final authRepo = AuthRepo();

    return App(
      authRepo: authRepo,
    );
  });
}
