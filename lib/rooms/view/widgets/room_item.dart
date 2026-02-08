import 'package:chat_now/rooms/data/models/room_model.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.roomModel});
  final RoomModel roomModel;
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
            Text(roomModel.name, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              roomModel.description,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
