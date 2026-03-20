import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // TODO: Implement actual sign up logic (e.g., Firebase or API call)
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthSuccess("Account created successfully!"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      // TODO: Implement actual forgot password logic
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthPasswordResetSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void reset() {
    emit(AuthInitial());
  }
}
