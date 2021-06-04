import 'package:firebase_auth/firebase_auth.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future createAcount(String nom, prenom, email, password, profession) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      AdminMedcinData(uid: user.uid)
          .updateUser(nom, prenom, email, profession, password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future changePassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
