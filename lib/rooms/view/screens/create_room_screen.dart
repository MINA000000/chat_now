import 'package:chat_now/auth/view/widgets/default_elevated_button.dart';
import 'package:chat_now/auth/view/widgets/default_text_form.dart';
import 'package:chat_now/shared/app_theme.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({super.key});
  static String route = '/create-room-screen';
  final roomNameController = TextEditingController();
  final roomDescController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Now', style: Theme.of(context).textTheme.bodyLarge),
      ),
      extendBodyBehindAppBar: true,
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
              // width: 100,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.white,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Create New Room',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Image.asset('assets/images/people.png', height: 100),
                    SizedBox(height: 12),
                    DefaultTextForm(
                      hint: 'Enter Room Name',
                      controller: roomNameController,
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return 'room name should be more than 2 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    DropdownButtonFormField(
                      hint: Text('Select Room Category'),
                      items: ['Sports', 'Movies', 'Music']
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        selectedCategory = value;
                      },
                      validator: (value) {
                        if (selectedCategory == null) {
                          return 'select category first';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    DefaultTextForm(
                      hint: 'Enter Room Description',
                      controller: roomDescController,
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return 'room description should be more than 2 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    DefaultElevatedButton(onPress: createRoom, text: 'Create'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createRoom() {
    if (formKey.currentState?.validate() == true) {}
  }
}
