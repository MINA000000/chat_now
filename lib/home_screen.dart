import 'package:chat_now/rooms/view/screens/create_room_screen.dart';
import 'package:chat_now/rooms/view/widgets/room_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static final String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (_, index) => RoomItem(),
                  itemCount: 10,
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
                Navigator.pushNamed(context, CreateRoomScreen.route);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
