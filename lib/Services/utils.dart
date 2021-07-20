import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UtilsService {
  Future<String> uploadFile(File _image, String path) async {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref(path);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);
    String returnURL = '';
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
      print("URL:  $returnURL");
    });
    print("return URL:  $returnURL");
    return returnURL;
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print("File: ${file.lengthSync()}");
    print("File: ${result.lengthSync()}");
    return result;
  }
}
