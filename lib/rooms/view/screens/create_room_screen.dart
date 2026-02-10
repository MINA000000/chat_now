import 'package:chat_now/auth/view/widgets/default_elevated_button.dart';
import 'package:chat_now/auth/view/widgets/default_text_form.dart';
import 'package:chat_now/rooms/data/models/category_model.dart';
import 'package:chat_now/rooms/data/models/room_model.dart';
import 'package:chat_now/rooms/view_model/rooms_states.dart';
import 'package:chat_now/rooms/view_model/rooms_view_model.dart';
import 'package:chat_now/shared/app_theme.dart';
import 'package:chat_now/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({super.key});
  static String route = '/create-room-screen';
  final roomNameController = TextEditingController();
  final roomDescController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedCategory;
  final viewModel = RoomsViewModel();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        items: CategoryModel.categories
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          selectedCategory = value!.id;
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
                      BlocListener<RoomsViewModel, RoomsState>(
                        listener: (_, state) {
                          if(state is CreateRoomLoading){
                            UiUtils.showLoading(context);
                          }
                          else if(state is CreateRoomError){
                            UiUtils.hideLoading(context);
                            UiUtils.showMessage(state.message, Colors.red);
                          }
                          else if(state is CreateRoomSuccess){
                            UiUtils.hideLoading(context);
                            UiUtils.showMessage('Room Created Successfully', Colors.green);
                            if(context.mounted){
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: DefaultElevatedButton(
                          onPress: createRoom,
                          text: 'Create',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createRoom() async{
    if (formKey.currentState?.validate() == true) {
      await viewModel.createRoom(
        RoomModel(
          categoryId: selectedCategory!,
          description: roomDescController.text,
          name: roomNameController.text,
        ),
      );
    }
  }
}
