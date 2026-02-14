import 'package:chat_now/auth/models/user_model.dart';
import 'package:chat_now/auth/view_model/auth_states.dart';
import 'package:chat_now/shared/firebase_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewModel extends Cubit<AuthState> {
  AuthViewModel() : super(AuthInitial());
  UserModel? currentUser;
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final user = await FirebaseFunctions.login(
        email: email,
        password: password,
      );
      currentUser = user;
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    try {
      final user = await FirebaseFunctions.register(
        name: name,
        email: email,
        password: password,
      );
      currentUser = user;
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await FirebaseFunctions.logout();
      currentUser = null;
      emit(LogoutSuccess());
    } catch (error) {
      emit(LogoutError(error.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await FirebaseFunctions.getCurrentUser();
      if (currentUser != null) {
        emit(IsLoggedIn());
      } else {
        emit(IsLoggedOut());
      }
    } catch (_) {
      emit(IsLoggedOut());
    }
  }
}
