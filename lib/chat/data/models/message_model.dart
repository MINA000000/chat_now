import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
   String id;
  final String content;
  final DateTime dateTime;
  final String senderId;
  final String sernderName;
  MessageModel({
    required this.content,
    required this.dateTime,
     this.id='',
    required this.senderId,
    required this.sernderName
  });

  MessageModel.fromJson(Map<String, dynamic> json)
    : this(
        content: json['content'],
        dateTime: (json['dateTime'] as Timestamp).toDate(),
        id: json['id'],
        senderId: json['senderId'],
        sernderName: json['senderName']
      );  

  Map<String, dynamic> tojson() => {
    'content': content,
    'dateTime': FieldValue.serverTimestamp(),
    'id': id,
    'senderId': senderId,
    'senderName':sernderName
  };
}
