import 'package:chat_now/chat/view/widgets/received_message.dart';
import 'package:chat_now/chat/view/widgets/sent_message.dart';
import 'package:chat_now/shared/app_theme.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const String route = '/chat-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        if (index % 2 == 0) {
                          return SentMessage(message: 'This is sent message');
                        } else {
                          return ReceivedMessage(
                            message:
                                'This is sent message This is sent message',
                          );
                        }
                      },
                      itemCount: 7,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, _) => SizedBox(height: 8),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
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
                        onPressed: () {},
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
    );
  }
}
