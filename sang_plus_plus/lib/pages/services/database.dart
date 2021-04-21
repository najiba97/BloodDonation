import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UserData {
  final String uid;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  UserData({this.uid});

  Future updateUser(String nom, String prenom, String telephone, String email,
      String password) async {
    return await users.doc(uid).set({
      'nom': nom,
      'prénom': prenom,
      'téléphone': telephone,
      'email': email,
      'mot de passe': password,
      'photo de profile': null
    });
  }

  Future userPic(String img) async {
    return await users.doc(uid).update({'photo de profile': img});
  }

  Stream<QuerySnapshot> userInfo() {
    return users.snapshots();
  }
}
