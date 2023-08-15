import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadDataFirebase {
  var newUrl;
  final storage = FirebaseStorage.instance;
  int imagename = DateTime.now().millisecond;

  Future<void> UploadDataFireStore(
      File image, String title, String description) async {
    Reference ref = FirebaseStorage.instance.ref('/Images/$imagename');
    UploadTask upload = ref.putFile(image);
    await Future.value(upload);
    newUrl = await ref.getDownloadURL();

    final id = DateTime.now().millisecond.toString();
    final datarefe = FirebaseDatabase.instance.ref('Blog');
    datarefe.child('posts details').child(id).set({
      'id': id,
      'Title': title,
      'Description': description,
      'Image': newUrl.toString(),
    });
  }
}
