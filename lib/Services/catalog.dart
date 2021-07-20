import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalog/models/catalogueModel.dart';
import 'package:catalog/services/utils.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CatalogService {
  UtilsService _utilsService = UtilsService();

  String id = FirebaseAuth.instance.currentUser.uid;
  List<CatalogModel> _catalogListFromSnapshot(QuerySnapshot snapshot) {
    print(snapshot.docs.length);
    return snapshot.docs.map((doc) {
      return CatalogModel(
        id: doc.id,
        name: doc.data()['name'] ?? '',
        discription: doc.data()['discription'] ?? '',
        price: doc.data()['price'] ?? 0,
        image: doc.data()['image'] ?? '',
        createrID: doc.data()['createrID'] ?? '',
      );
    }).toList();
  }

  Future saveCatalog(
      {String name, String price, String discription, File image}) async {
    String pushId = "";
    String imageUrl = '';
    await FirebaseFirestore.instance.collection("catalog").add({
      "name": name,
      'discription': discription,
      'price': price,
      'createrID': FirebaseAuth.instance.currentUser.uid,
      'image': imageUrl,
    }).then((value) {
      pushId = value.id;
    });
    print("pushID: $pushId");

    imageUrl = await _utilsService.uploadFile(image, 'catalog/$pushId/image');

    Map<String, Object> data = new HashMap();
    if (imageUrl != '') data['image'] = imageUrl;
    print("data ${data['image']}");
    await FirebaseFirestore.instance
        .collection('catalog')
        .doc(pushId)
        .update(data);
  }

  // Future AddImage(File image,String id) async{
  //   String imageUrl = '';
  //   if (image != null) {
  //     imageUrl = await _utilsService.uploadFile(image,
  //         '${FirebaseAuth.instance.currentUser.uid}/id/image');
  //   }
  //   Map<String, Object> data = new HashMap();
  // }

  Stream<List<CatalogModel>> getCatalogByUser(uid) {
    print(uid);
    return FirebaseFirestore.instance
        .collection("catalog")
        .snapshots()
        .map(_catalogListFromSnapshot);
  }

  Future<List<CatalogModel>> getFeed() async {
    List<CatalogModel> feedList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('catalog')
        .where('createrID', isEqualTo: id)
        .get();
    feedList.addAll(_catalogListFromSnapshot(querySnapshot));
    return feedList;
  }

  // Future<void> addImage(File _image, String id) async {
  //   String imageUrl = '';

  //   if (_image != null) {
  //     final dir = await path_provider.getTemporaryDirectory();
  //     final targetPath = dir.absolute.path + "/temp.jpg";
  //     File imageCompressed =
  //         await _utilsService.testCompressAndGetFile(_image, targetPath);
  //     imageUrl =
  //         await _utilsService.uploadFile(imageCompressed, 'catalog/$id/image');
  //   }
  // }
}
