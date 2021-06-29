import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus_admin/screens/authentification/auth_admin.dart';
import 'package:sang_plus_plus_admin/screens/authentification/passe.dart';
import 'package:sang_plus_plus_admin/screens/confirmer.dart';
import 'package:sang_plus_plus_admin/screens/create_event.dart';

import 'package:sang_plus_plus_admin/screens/cree_compte/cree_compte.dart';
import 'package:sang_plus_plus_admin/screens/gerer_useres.dart';
import 'package:sang_plus_plus_admin/screens/gestion_rendezvs.dart';
import 'package:sang_plus_plus_admin/screens/loading.dart';
import 'package:sang_plus_plus_admin/screens/menu/menu.dart';
import 'package:sang_plus_plus_admin/services/database.dart';
import 'package:sang_plus_plus_admin/widgets/accept.dart';
import 'package:sang_plus_plus_admin/widgets/rendez_vous_perso.dart';

import 'screens/first_page.dart';

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
    return StreamProvider<QuerySnapshot>.value(
      value: AdminMedcinData().rendezVous,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/auth': (context) => Auth(),
          '/auth_admin': (context) => AuthAdmin(),
          '/cree_compte': (context) => CreeCompte(),
          '/menu': (context) => Menu(),
          '/passe': (context) => Passe(),
          '/gestion_rendezvs': (context) => GestionRendezVous(),
          '/create_event': (context) => CreateEvent(),
          '/rendez_perso': (context) => RendezPerso(),
          '/accept': (context) => Accept(),
          '/confirm_rendezvous': (context) => ConfirmerRendezVous(),
          '/gerer_utilisateur': (context) => GererUser(),
        },
      ),
    );
  }
}
