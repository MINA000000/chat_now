import 'package:chat_now/auth/view_model/auth_view_model.dart';
import 'package:chat_now/chat/data/models/message_model.dart';
import 'package:chat_now/chat/view/widgets/received_message.dart';
import 'package:chat_now/chat/view/widgets/sent_message.dart';
import 'package:chat_now/chat/view_model/chat_states.dart';
import 'package:chat_now/chat/view_model/chat_view_model.dart';
import 'package:chat_now/rooms/data/models/room_model.dart';
import 'package:chat_now/shared/app_theme.dart';
import 'package:chat_now/shared/widgets/error_indicator.dart';
import 'package:chat_now/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String route = '/chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final viewModel = ChatViewModel();
  List<MessageModel> messages = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final room = ModalRoute.of(context)!.settings.arguments as RoomModel;
      viewModel.room = room;
      viewModel.user = context.read<AuthViewModel>().currentUser;
      viewModel.getMessages();
    });
    // viewModel.getMessages().;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text('chat Screen'), centerTitle: true),
        body: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              stops: [0.25, 0.25],
            ),
          ),
          child: Center(
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                padding: EdgeInsets.all(12),
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<ChatViewModel, ChatState>(
                        buildWhen: (previous, current) =>
                            previous is GetMessagesLoading ||
                            current is GetMessagesLoading,
                        builder: (_, state) {
                          if (state is GetMessagesLoading) {
                            return LoadingIndicator();
                          } else if (state is GetMessagesError) {
                            return ErrorIndicator();
                          } else if (state is GetMessagesSuccess) {
                            return StreamBuilder(
                              stream: state.messagesStream,
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  messages = snapshot.data!;
                                }
                                return ListView.separated(
                                  itemBuilder: (_, index) {
                                    if (messages[index].senderId ==
                                        viewModel.user!.id) {
                                      return SentMessage(
                                        message: messages[index],
                                      );
                                    } else {
                                      return ReceivedMessage(
                                        message: messages[index],
                                      );
                                    }
                                  },
                                  reverse: true,
                                  itemCount: messages.length,
                                  padding: EdgeInsets.zero,
                                  separatorBuilder: (_, _) =>
                                      SizedBox(height: 8),
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: viewModel.messageController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              contentPadding: EdgeInsetsDirectional.only(
                                start: 8,
                              ),
                            ),
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.sendMessage();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: AppTheme.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text('Send'),
                              SizedBox(width: 8),
                              Icon(Icons.send),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
