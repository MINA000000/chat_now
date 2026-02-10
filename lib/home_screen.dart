import 'package:chat_now/chat/view/screens/chat_screen.dart';
import 'package:chat_now/rooms/view/screens/create_room_screen.dart';
import 'package:chat_now/rooms/view/widgets/room_item.dart';
import 'package:chat_now/rooms/view_model/rooms_states.dart';
import 'package:chat_now/rooms/view_model/rooms_view_model.dart';
import 'package:chat_now/shared/widgets/error_indicator.dart';
import 'package:chat_now/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final String route = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = RoomsViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            stops: [0.25, 0.25],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'Chat Now',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<RoomsViewModel, RoomsState>(
                    builder: (context, state) {
                      if (state is GetRoomsLoading) {
                        return LoadingIndicator();
                      } else if (state is GetRoomsError) {
                        return ErrorIndicator(message: state.message);
                      } else if (state is GetRoomsSuccess) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          itemBuilder: (_, index) => InkWell(
                            onTap: () => Navigator.of(context).pushNamed(ChatScreen.route),
                            child: RoomItem(roomModel: viewModel.rooms[index]),
                          ),
                          itemCount: viewModel.rooms.length,
                        );
                      }
                      return const Center(child: Text('No Rooms'));
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            height: 60.0,
            width: 60.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CreateRoomScreen.route,
                  ).then((_) => viewModel.getRooms());
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
