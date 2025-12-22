import 'package:bikex/app/app.dart';
import 'package:bikex/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  group('App', () {
    late MockAuthRepo mockAuthRepo;

    setUp(() {
      mockAuthRepo = MockAuthRepo();
      when(() => mockAuthRepo.user).thenAnswer(
        (_) => Stream.value(User.empty),
      );
      when(() => mockAuthRepo.currentUser).thenReturn(User.empty);
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(App(authRepo: mockAuthRepo));
      await tester.pump();
      // App should render without errors
      expect(find.byType(App), findsOneWidget);
    });
  });
}
