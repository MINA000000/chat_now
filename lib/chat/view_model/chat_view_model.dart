import 'package:chat_now/auth/models/user_model.dart';
import 'package:chat_now/chat/data/models/message_model.dart';
import 'package:chat_now/chat/view_model/chat_states.dart';
import 'package:chat_now/rooms/data/models/room_model.dart';
import 'package:chat_now/shared/firebase_functions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewModel extends Cubit<ChatState> {
  ChatViewModel() : super(ChatInitial());
  final messageController = TextEditingController();
  RoomModel? room;
  UserModel? user;

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;
    emit(SendMessageLoading());
    try {
      final message = MessageModel(
        sernderName: user!.name,
        content: messageController.text,
        dateTime: DateTime.now(),
        senderId: user!.id,
      );
      await FirebaseFunctions.sendMessage(message, room!.id);
      messageController.clear();
      emit(SendMessageSuccess());
    } catch (error) {
      print(error);
      emit(SendMessageError());
    }
  }

  Future<void> getMessages() async {
    emit(GetMessagesLoading());
    try {
      final messagesStream = FirebaseFunctions.getMessagesStream(room!.id);
      emit(GetMessagesSuccess(messagesStream));
    } catch (error) {
      // print(user!.toJson());
      print(error);
      emit(GetMessagesError());
    }
  }

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
