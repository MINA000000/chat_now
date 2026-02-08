import 'package:chat_now/rooms/data/models/room_model.dart';
import 'package:chat_now/rooms/view_model/rooms_states.dart';
import 'package:chat_now/shared/firebase_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsViewModel extends Cubit<RoomsState> {
  RoomsViewModel() : super(RoomsInitial());
  List<RoomModel> rooms = [];
  Future<void> getRooms() async {
    emit(GetRoomsLoading());
    try {
      rooms = await FirebaseFunctions.getRooms();
      emit(GetRoomsSuccess());
    } catch (error) {
      emit(GetRoomsError(error.toString()));
    }
  }

  Future<void> createRoom(RoomModel room) async {
    emit(CreateRoomLoading());
    try {
      await FirebaseFunctions.createRoom(room);
      emit(CreateRoomSuccess());
    } catch (error) {
      emit(CreateRoomError(error.toString()));
    }
  }
}
