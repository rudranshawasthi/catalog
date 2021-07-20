import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogModel {
  final String id;
  final String name;
  final String discription;
  final String price;
  final String image;
  final String createrID;

  CatalogModel({
    this.id,
    this.name,
    this.price,
    this.discription,
    this.image,
    this.createrID,
  });
}
