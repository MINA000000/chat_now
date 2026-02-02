import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiUtils {
  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    ),
  );
  static void hideLoading(BuildContext context) => Navigator.pop(context);

  static void showMessage(String message,Color color) => Fluttertoast.showToast(
    msg: message,
    backgroundColor: color,
    textColor: Colors.white,
  );
}
