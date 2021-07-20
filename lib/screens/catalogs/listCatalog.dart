import 'package:catalog/models/catalogueModel.dart';
import 'package:catalog/models/user.dart';
import 'package:catalog/Services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalog/Services/catalog.dart';

class ListCatalog extends StatefulWidget {
  @override
  _ListCatalogState createState() => _ListCatalogState();
}

class _ListCatalogState extends State<ListCatalog> {
  UserService _userService = UserService();
  CatalogService _catalogService = CatalogService();
  String uid = FirebaseAuth.instance.currentUser.uid;
  List<CatalogModel> catalogs = [];

  @override
  Widget build(BuildContext context) {
    if (catalogs.isEmpty)
      catalogs = Provider.of<List<CatalogModel>>(context) ?? [];
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          itemCount: catalogs.length,
          itemBuilder: (context, index) {
            final catalog = catalogs[index];
            return StreamBuilder(
                stream: _userService.getUserInfo(uid),
                builder: (BuildContext context,
                    AsyncSnapshot<UserModel> snapshotUser) {
                  if (!snapshotUser.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListTile(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: catalog.image.length > 0
                          ? Container(
                              height: 100,
                              child: Image.network(
                                catalog.image,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Icon(
                              Icons.image,
                              size: 30,
                            ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(catalog.name),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(catalog.discription),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(catalog.price.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                });
          },
        ));
  }

  Future<void> _pullRefresh() async {
    catalogs = await _catalogService.getFeed();
    setState(() {});
  }
}
