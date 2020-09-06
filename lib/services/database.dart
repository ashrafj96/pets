import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pets/services/auth.dart';

abstract class Database {
  Future<void> createUser(User user);
  void readUserData();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  String displayName;

  void readUserData() async {
    final snapshot = await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((snapshot) => {
              print(snapshot.data),
              displayName = snapshot.data['displayName'],
            });
    // return reference

    // print(reference.asStream());
    // final snapshots = reference.getDocuments();
    // print(snapshots.asStream());
    // snapshots.listen((snapshot) {
    //   snapshot.documents.forEach((snapshot) => print(snapshot.data));
    // });
  }

  Future<void> createUser(User user) async {
    final path = '/users/$uid/';
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(user.toMap());
  }
}
