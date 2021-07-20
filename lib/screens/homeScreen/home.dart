import 'package:catalog/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalog/Services/catalog.dart';
import 'package:catalog/screens/catalogs/listCatalog.dart';
import 'package:catalog/models/catalogueModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CatalogService _catalogService = CatalogService();
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider.value(
      value: _catalogService.getFeed(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Feed"),
          backgroundColor: Colors.blue,
          actions: [
            FlatButton(
                onPressed: () {
                  authService.signOut();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/addDetails');
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListCatalog(),
      ),
    );
  }
}
