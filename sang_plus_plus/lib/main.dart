import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus/pages/apropos.dart';
import 'package:sang_plus_plus/pages/authentification/authentification.dart';
import 'package:sang_plus_plus/pages/consigne.dart';
import 'package:sang_plus_plus/pages/contact.dart';
import 'package:sang_plus_plus/pages/authentification/cree_compte.dart';
import 'package:sang_plus_plus/pages/loading.dart';
import 'package:sang_plus_plus/pages/menu.dart';
import 'package:sang_plus_plus/pages/profile.dart';
import 'package:sang_plus_plus/pages/quiz.dart';
import 'package:sang_plus_plus/pages/quizFemme.dart';
import 'package:sang_plus_plus/pages/quizHomme.dart';
import 'package:sang_plus_plus/pages/rendez_vous.dart';
import 'package:sang_plus_plus/pages/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthServices().authStateChanges,
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Roboto'),
          initialRoute: '/',
          routes: {
            '/': (context) => Loading(),
            '/authentif': (context) => Authentif(),
            '/creeCompte': (context) => CreateCount(),
            '/menu': (context) => Menu(),
            //'/location': (context) => Location(),
            '/quiz': (context) => Quiz(),
            '/quizFemme': (context) => QuizFemme(),
            '/quizHomme': (context) => QuizHomme(),
            '/profile': (context) => Profile(),
            '/consigne': (context) => Consigne(),
            '/propos': (context) => Propos(),
            '/contacte': (context) => Contacte(),
            '/rendez': (context) => Rendez()
          }),
    );
  }
}
