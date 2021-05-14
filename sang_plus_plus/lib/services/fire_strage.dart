import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorageService extends ChangeNotifier {
  String uid;
  FireStorageService({this.uid});

  Future<String> downloadImage() async {
    final img =
        await FirebaseStorage.instance.ref().child(uid).getDownloadURL();
    return img;
  }
}
