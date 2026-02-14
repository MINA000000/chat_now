import 'package:chat_now/auth/models/user_model.dart';
import 'package:chat_now/chat/data/models/message_model.dart';
import 'package:chat_now/rooms/data/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getCollectionUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );
  static CollectionReference<RoomModel> getCollectionRooms() =>
      FirebaseFirestore.instance
          .collection('rooms')
          .withConverter<RoomModel>(
            fromFirestore: (snapshot, _) =>
                RoomModel.fromJson(snapshot.data()!),
            toFirestore: (roomModel, _) => roomModel.toJson(),
          );
  static CollectionReference<MessageModel> getCollectionMessages(
    String roomId,
  ) => getCollectionRooms()
      .doc(roomId)
      .collection('chat')
      .withConverter<MessageModel>(
        fromFirestore: (snapshot, _) => MessageModel.fromJson(snapshot.data()!),
        toFirestore: (messageModel, _) => messageModel.tojson(),
      );

  static Future<UserModel> register({
    required String email,
    required String name,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollection = getCollectionUsers();
    UserModel userModel = UserModel(
      email: email,
      id: userCredential.user!.uid,
      name: name,
    );
    usersCollection.doc(userCredential.user!.uid).set(userModel);
    return userModel;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return getUser(userCredential.user!.uid);
  }

  static Future<void> logout()async{
    return FirebaseAuth.instance.signOut();
  }

  static Future<UserModel> getUser(String userId)async{
    CollectionReference<UserModel> usersCollection = getCollectionUsers();
    DocumentSnapshot<UserModel> documentSnapshot = await usersCollection
        .doc(userId)
        .get();
    return documentSnapshot.data()!;
  }

  static Future<UserModel?> getCurrentUser()async{
    if(FirebaseAuth.instance.currentUser == null) return null;
    final currentUser = getUser(FirebaseAuth.instance.currentUser!.uid);
    return currentUser;
  }
  static Future<List<RoomModel>> getRooms() async {
    final roomsCollection = getCollectionRooms();
    QuerySnapshot<RoomModel> querySnapshot = await roomsCollection.get();
    final rooms = querySnapshot.docs
        .map((queryDocumentSnapshot) => queryDocumentSnapshot.data())
        .toList();
    return rooms;
  }

  static Future<void> createRoom(RoomModel room) async {
    final roomCollection = getCollectionRooms();
    final roomDoc = roomCollection.doc();
    room.id = roomDoc.id;
    return roomDoc.set(room);
  }

  static Future<void> sendMessage(MessageModel message, String roomId) {
    final messagesCollection = getCollectionMessages(roomId);
    final messageDoc = messagesCollection.doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }

  static Stream<List<MessageModel>> getMessagesStream(String roomId) {
    final messagesCollection = getCollectionMessages(roomId);
    return messagesCollection.orderBy('dateTime',descending: true).snapshots().map(
      (querySnapshot) => querySnapshot.docs.map(
        (queryDocumentSnapshot) => queryDocumentSnapshot.data(),
      ).toList(),
    );
  }
}
