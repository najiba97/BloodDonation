import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uid;
  //instancier la collection qui va etre dans le firestore
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  UserData({this.uid});
  // upadateUser va prendre les information donner par user et les mettre en documents firestore
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

  /* va mettre a jours la propriete photo de profile si l'utilisateur decide de mettre
  a jours sa photo de profile*/
  Future userPic(String img) async {
    return await users.doc(uid).update({'photo de profile': img});
  }

  //stream qui nous donne une snapshot sur le document users en firestore
  Stream<QuerySnapshot> userInfo() {
    return users.snapshots();
  }
}
