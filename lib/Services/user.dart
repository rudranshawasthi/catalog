import 'dart:collection';
import 'dart:io';

import 'package:catalog/models/user.dart';
// import 'package:catalog/screens/main/home/search.dart';
import 'package:catalog/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

  // List<UserModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     print(doc.data());

  //     print(doc.get('name'));
  //     return UserModel(
  //       id: doc.id,
  //       email: doc.data()['email'] ?? '',
  //     );
  //   }).toList();
  // }

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            id: snapshot.id,
            email: snapshot.data()['email'] ?? '',
          )
        : null;
  }

  Stream<UserModel> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }
}
