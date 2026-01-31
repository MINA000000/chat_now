import 'package:chat_now/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  UserModel? currentUser;

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    currentUser = null;
    notifyListeners();
  }
}
