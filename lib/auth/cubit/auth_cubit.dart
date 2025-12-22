import 'dart:async';
import 'package:bikex/auth/auth.dart';
import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(const AuthUnknown()) {
    _userSubscription = authRepo.user.listen(_onUserChanged);
  }

  final AuthRepo authRepo;
  StreamSubscription<User>? _userSubscription;

  void _onUserChanged(User user) {
    if (user.isNotEmpty) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await authRepo.signIn(email: email, password: password);
      // State will update via stream
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password, String username) async {
    try {
      await authRepo.signUp(
        email: email,
        password: password,
        name: username,
      );
      // State will update via stream
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await authRepo.signOut();
      // State will update via stream
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _userSubscription?.cancel();
    return super.close();
  }
}
