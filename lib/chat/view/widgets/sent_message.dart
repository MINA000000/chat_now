import 'package:flutter/material.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(8),
            topEnd: Radius.circular(8),
            bottomStart: Radius.circular(8),
          ),
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
