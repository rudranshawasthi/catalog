import 'package:catalog/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:catalog/models/user.dart';
import 'package:catalog/Services/auth.dart';

void main() {
  runApp(CatalogApp());
}

class CatalogApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            // return SomethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<UserModel>.value(
              value: AuthService().user,
              child: MaterialApp(home: Wrapper()),
            );
          }
          return MaterialApp(home: Scaffold(body: Text("Loading")));
        });
  }
}
