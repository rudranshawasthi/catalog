import 'package:flutter/material.dart';
import 'dart:io';
import 'package:catalog/Services/catalog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:catalog/flash_helper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:catalog/services/utils.dart';

class AddState extends StatefulWidget {
  @override
  _AddStateState createState() => _AddStateState();
}

class _AddStateState extends State<AddState> {
  final CatalogService _catalogService = CatalogService();
  String name = "";
  String price = "";
  String discription = "";
  final picker = ImagePicker();
  File _image;
  UtilsService _utilsService = UtilsService();

  @override
  Widget build(BuildContext context) {
    print("Add details");
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) {
                    name = val;
                  },
                ),
                TextFormField(
                  onChanged: (val) {
                    price = val;
                  },
                ),
                TextFormField(
                  onChanged: (val) {
                    discription = val;
                  },
                ),
                TextButton(
                  onPressed: () {
                    getImage(0);
                    FlashHelper.informationBar(context,
                        message: "Orignal Size : ${_image.lengthSync()}");
                  },
                  child: _image == null
                      ? Icon(Icons.image)
                      : Image.file(
                          _image,
                          height: 100,
                        ),
                ),
                FlatButton(
                  onPressed: () async {
                    final dir = await path_provider.getTemporaryDirectory();
                    final targetPath = dir.absolute.path + "/temp.jpg";
                    File imageCompressed = await _utilsService
                        .compressAndGetFile(_image, targetPath);
                    FlashHelper.informationBar(context,
                        message:
                            "Compressed : ${imageCompressed.lengthSync()}");
                    _catalogService.saveCatalog(
                      name: name,
                      discription: discription,
                      price: price,
                      image: imageCompressed,
                    );
                    Navigator.popAndPushNamed(context, '/');
                  },
                  child: Text("Add"),
                )
              ],
            )),
      ),
    );
  }

  Future getImage(int type) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null && type == 0) {
        _image = File(pickedFile.path);
      }
    });
  }
}
