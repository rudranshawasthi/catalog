import 'dart:collection';
import 'dart:io';

import 'package:catalog/models/user.dart';
import 'package:catalog/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

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
