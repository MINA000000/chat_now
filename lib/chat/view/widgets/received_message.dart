import 'package:chat_now/shared/app_theme.dart';
import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.greyColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(8),
            topEnd: Radius.circular(8),
            bottomEnd: Radius.circular(8),
          ),
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
