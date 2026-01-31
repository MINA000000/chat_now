import 'package:chat_now/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getCollectionUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.toJson(),
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
    CollectionReference<UserModel> usersCollection = getCollectionUsers();
    DocumentSnapshot<UserModel> documentSnapshot = await usersCollection
        .doc(userCredential.user!.uid)
        .get();
    return documentSnapshot.data()!;
  }
}
