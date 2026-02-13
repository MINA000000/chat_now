import 'package:chat_now/chat/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            DateFormat.jm().format(message.dateTime),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(8),
                topEnd: Radius.circular(8),
                bottomStart: Radius.circular(8),
              ),
            ),
            child: Text(message.content, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
