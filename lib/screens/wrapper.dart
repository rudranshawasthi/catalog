import 'package:catalog/screens/homeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalog/models/user.dart';
import 'package:catalog/screens/authenticate/auth.dart';
import 'package:catalog/screens/catalogs/saveDetails.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    print(user);

    if (user == null) {
      return SignUp();
    }

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/addDetails': (context) => AddState(),
      },
    );
  }
}
