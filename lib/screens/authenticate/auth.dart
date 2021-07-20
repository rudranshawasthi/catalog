import 'package:catalog/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: Text("Sign Up"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: new Form(
            child: Column(
          children: [
            TextFormField(
              onChanged: (val) => setState(() {
                email = val;
              }),
            ),
            TextFormField(
              obscureText: true,
              onChanged: (val) => setState(() {
                password = val;
              }),
            ),
            RaisedButton(
              onPressed: () async {
                _authService.signUp(email, password);
              },
              child: Text("Signup"),
            ),
            RaisedButton(
              onPressed: () async {
                _authService.signIn(email, password);
              },
              child: Text("SignIN"),
            )
          ],
        )),
      ),
    );
  }
}
