import 'package:chat_now/chat/data/models/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageLoading extends ChatState {}

class SendMessageSuccess extends ChatState {}

class SendMessageError extends ChatState {}

class GetMessagesLoading extends ChatState {}

class GetMessagesSuccess extends ChatState {
  final Stream<List<MessageModel>> messagesStream;
  GetMessagesSuccess(this.messagesStream);
}

class GetMessagesError extends ChatState {}