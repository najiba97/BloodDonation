import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminMedcinData {
  final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference administrateurMedecin =
      FirebaseFirestore.instance.collection('adminMedecin');
  AdminMedcinData({this.uid});

  Future updateUser(String nom, prenom, email, identif, password) async {
    return await administrateurMedecin.doc(uid).set({
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'identif': identif,
      'password': password,
    });
  }

  Stream<DocumentSnapshot> get job =>
      administrateurMedecin.doc(_auth.currentUser.uid).snapshots();
}
