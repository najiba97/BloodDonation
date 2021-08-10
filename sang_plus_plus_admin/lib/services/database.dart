import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminMedcinData {
  final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference forms =
      FirebaseFirestore.instance.collection('forms');
  final CollectionReference notif =
      FirebaseFirestore.instance.collection('notification');
  final CollectionReference tabDate =
      FirebaseFirestore.instance.collection('dateRendezVous');
  final CollectionReference stat =
      FirebaseFirestore.instance.collection('statistique');
  final CollectionReference event =
      FirebaseFirestore.instance.collection('event');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  FirebaseAuth auth = FirebaseAuth.instance;

  AdminMedcinData({this.uid});

  Future updateUser(String nom, prenom, email, identif, password) async {
    return await users.doc(uid).set({
      'nom': nom,
      'prénom': prenom,
      'téléphone': null,
      'email': email,
      'uid': auth.currentUser.uid,
      'photo de profile': null,
      'identif': identif,
      'donner': false,
      'nombre de don': 0,
      'date don': null,
      'demande en cours': false,
    });
  }

  Future setNotif() async {
    return await notif.doc(uid).set({
      'date&heure': null,
      'read': false,
    });
  }

  Future prendreRendezVous(
      String nom, prenom, email, telephone, date, sexe, gs) async {
    return await forms.doc(_auth.currentUser.uid).set({
      'nom': nom,
      'prénom': prenom,
      'email': email,
      'téléphone': telephone,
      'date': date,
      'sexe': sexe,
      'groupe sanguin': gs,
      'accepter': false,
      'uid': auth.currentUser.uid,
      'demande en cours': false,
    });
  }

  Future createDateRendezVous(String nom, prenom, sexe, gs, uid, date) async {
    return await tabDate.doc(uid).set({
      'nom&prénomDonneur': nom + ' ' + prenom,
      'sexe': sexe,
      'groupe sanguin': gs,
      'uid': uid,
      'confirmed': false,
      'date': date,
    });
  }

  Future updateInfo(String prop, String value, String uid) async {
    return await tabDate.doc(uid).update({prop: value});
  }

  Future updateNotif(String dateHeure, myUid) async {
    return await notif.doc(myUid).update({
      'date&heure': dateHeure,
    });
  }

  Future deleteRendezVous(String uid) async {
    return await tabDate.doc(uid).delete();
  }

  Future reUpdateNotif(String uid) async {
    return await notif.doc(uid).update({
      'date&heure': null,
      'read': false,
    });
  }

  Future demandeRecu(String uid) async {
    return await users.doc(uid).update({
      'demande en cours': false,
    });
  }

  Future confirmGsSex(String sexe, gs, uid) async {
    return await tabDate.doc(uid).update({
      'sexe': sexe,
      'groupe sanguin': gs,
      'confirmed': true,
    });
  }

  Future dateDon(String date, uid) async {
    await users.doc(uid).update({
      'date don': date,
    });
  }

  Future effacerRendez(uid) async {
    return await forms.doc(uid).delete();
  }

  Future updateStat(prop, value) async {
    return await stat.doc('stat').update({
      prop: FieldValue.increment(value),
    });
  }

  Future createEvent(String lieux, date, image) async {
    return await event.doc().set({
      'lieux': lieux,
      'date': date,
      'image': image,
    });
  }

  Future changeIdentif(String uid, identif) async {
    return await users.doc(uid).update({
      'identif': identif,
    });
  }

  Stream<QuerySnapshot> get infouser {
    return users.snapshots();
  }

  Stream<DocumentSnapshot> get job =>
      users.doc(_auth.currentUser.uid).snapshots();

  Stream<QuerySnapshot> get rendezVous {
    return forms.snapshots();
  }

  Stream<QuerySnapshot> get date => tabDate.snapshots();

  Stream<DocumentSnapshot> get statis => stat.doc('stat').snapshots();
}
