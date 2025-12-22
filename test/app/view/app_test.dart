import 'package:bikex/app/app.dart';
import 'package:bikex/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders login page when unauthenticated', (tester) async {
      await tester.pumpWidget(App(authRepo: AuthRepo()));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
