import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String uid;
  //instancier la collection qui va etre dans le firestore
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  //instancier collection de formulaire dans le firestore
  final CollectionReference forms =
      FirebaseFirestore.instance.collection('forms');
  final CollectionReference notif =
      FirebaseFirestore.instance.collection('notification');
  final CollectionReference tabDate =
      FirebaseFirestore.instance.collection('dateRendezVous');

  FirebaseAuth auth = FirebaseAuth.instance;

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
      'photo de profile': null,
      'identif': 'utilisateur',
      'demande en cours': false,
      'donner': false,
      'nombre de don': 0,
      'date don': null,
    });
  }

  /* va mettre a jours la propriete photo de profile si l'utilisateur decide de mettre
  a jours sa photo de profile*/
  Future userPic(img) async {
    return await users.doc(uid).update({'photo de profile': img});
  }

  //stream qui nous donne une snapshot sur le document users en firestore
  Stream<QuerySnapshot> userInfo() {
    return users.snapshots();
  }

  // update nom and prenom

  Future updateInfo(String prop, dynamic value) async {
    return await users.doc(uid).update({prop: value});
  }

  // Prendre rendez vous

  Future prendreRendezVous(
      String nom, prenom, email, telephone, date, sexe, gs) async {
    return await forms.doc(uid).set({
      'nom': nom,
      'prénom': prenom,
      'email': email,
      'téléphone': telephone,
      'date': date,
      'sexe': sexe,
      'groupe sanguin': gs,
      'accepter': false,
      'envoyer': true,
      'uid': auth.currentUser.uid,
    });
  }

  Future setNotif() async {
    return await notif.doc(uid).set({
      'date&heure': null,
      'read': false,
    });
  }

  Future updateNotif() async {
    return await notif.doc(auth.currentUser.uid).update({
      'read': true,
    });
  }

   
  Future demandeEnvoyer() async {
    return await users.doc(auth.currentUser.uid).update({
      'demande en cours': true,
    });
  }

  Future createDateRendezVous(
      String dateHeure, nom, prenom, sexe, gs, uid) async {
    return await tabDate.doc(uid).set({
      'date don': dateHeure,
      'nom&prénomDonneur': nom + ' ' + prenom,
      'sexe': sexe,
      'groupe sanguin': gs,
      'uid': uid,
      'confirmed': false,
    });
  }

  Stream<DocumentSnapshot> get notification =>
      notif.doc(auth.currentUser.uid).snapshots();

  Stream<DocumentSnapshot> get rendez =>
      tabDate.doc(auth.currentUser.uid).snapshots();

  Stream<DocumentSnapshot> get userinfo =>
      users.doc(auth.currentUser.uid).snapshots();
}
