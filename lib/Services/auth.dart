import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalog/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserModel _userfromFirebaseUser(User user) {
    return user != null ? UserModel(id: user.uid) : null;
  }

  Stream<UserModel> get user {
    return firebaseAuth.authStateChanges().map(_userfromFirebaseUser);
  }

  Future signIn(email, password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)) as User;

      _userfromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future signUp(email, password) async {
    try {
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user.uid)
          .set({'name': email, "email": email});
      _userfromFirebaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
