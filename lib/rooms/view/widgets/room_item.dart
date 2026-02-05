import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Image.asset('assets/images/chatRoom1.png', height: 100),
            Text(
              'The group chat',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('13 members', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
