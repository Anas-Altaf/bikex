import 'dart:async';
import 'package:asra_ai/auth/models/models.dart';

class AuthRepo {
  AuthRepo() {
    // Auto-login after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _currentUser = const User(
        id: 'user1',
        email: 'john@test.com',
        name: 'John Doe',
      );
      _userController.add(_currentUser);
    });
  }
  // Mock users database
  final Map<String, String> _users = {
    'john@test.com': 'password',
    'alice@test.com': 'password',
  };

  final _userController = StreamController<User>.broadcast();
  User _currentUser = User.empty;

  Stream<User> get user => _userController.stream;
  User get currentUser => _currentUser;

  Future<void> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (_users[email] == password) {
      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: email.split('@').first.toUpperCase(),
      );
      _userController.add(_currentUser);
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    _users[email] = password;
    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: name,
    );
    _userController.add(_currentUser);
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _currentUser = User.empty;
    _userController.add(_currentUser);
  }

  Future<void> dispose() async {
    await _userController.close();
  }
}
