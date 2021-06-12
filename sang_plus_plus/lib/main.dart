import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus/pages/drawer_screens/propos.dart';
import 'package:sang_plus_plus/pages/authentification/authentification.dart';
import 'package:sang_plus_plus/pages/drawer_screens/consigne.dart';
import 'package:sang_plus_plus/pages/drawer_screens/contact.dart';
import 'package:sang_plus_plus/pages/authentification/cree_compte.dart';
import 'package:sang_plus_plus/pages/loading.dart';
import 'package:sang_plus_plus/pages/menu.dart';
import 'package:sang_plus_plus/pages/profile.dart';
import 'package:sang_plus_plus/pages/quiz/quiz.dart';
import 'package:sang_plus_plus/pages/quiz/quiz_femme.dart';
import 'package:sang_plus_plus/pages/quiz/quiz_homme.dart';
import 'package:sang_plus_plus/pages/drawer_screens/rendez_vous.dart';
import 'package:sang_plus_plus/pages/reset_pass.dart';

import 'services/auth_service.dart';

void main() async {
  // relier flutter avec fire base
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp va implementer la class MyApp
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // stream sur l'objet User (firebase)
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          initialData: null,
          value: AuthServices().authStateChanges,
        ),
      ],

      // le cible de stream (l'etat d'utilisateur null ou connecté)

      // Material App c'est la class main qui contiens tous leas autre class
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //theme va vous initialiser l'apparence d'application
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
            '/rendez': (context) => Rendez(),
            '/resetpass': (context) => ResetPassword(),
          }),
    );
  }
}
