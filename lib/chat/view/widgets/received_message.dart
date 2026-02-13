import 'package:chat_now/chat/data/models/message_model.dart';
import 'package:chat_now/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.sernderName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.greyColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(8),
                    topEnd: Radius.circular(8),
                    bottomEnd: Radius.circular(8),
                  ),
                ),
                child: Text(
                  message.content,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 8),
              Text(
                DateFormat.jm().format(message.dateTime),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
