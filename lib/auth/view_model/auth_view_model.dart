import 'package:chat_now/auth/models/user_model.dart';
import 'package:chat_now/auth/view_model/auth_states.dart';
import 'package:chat_now/shared/firebase_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
}

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    currentUser = null;
    notifyListeners();
  }
}
