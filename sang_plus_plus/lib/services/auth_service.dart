import 'package:firebase_auth/firebase_auth.dart';
import 'package:sang_plus_plus/models/my_user.dart';

import 'package:sang_plus_plus/services/database.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String authUid = '';

  //create user based on firebase user

  MyUser _createUserFromFireUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //create acount with email and password

  Future createAccount(String nom, String prenom, String telephone,
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      User fireUser = userCredential.user;
      MyUser myUser = _createUserFromFireUser(fireUser);
      UserData(uid: myUser.uid)
          .updateUser(nom, prenom, telephone, email, password);
      UserData(uid: myUser.uid).setNotif();
      
       
      return myUser.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User fireUser = userCredential.user;
      MyUser myUser = _createUserFromFireUser(fireUser);
      authUid = myUser.uid;

      return myUser.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future changePassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'nice';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // listen to user
  Stream<User> get authStateChanges => _auth.authStateChanges();
}
