import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus_admin/screens/gereradmin.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

import 'gerermedecin.dart';
import 'gererutilisateur.dart';

class GererUser extends StatefulWidget {
  @override
  _GererUserState createState() => _GererUserState();
}

class _GererUserState extends State<GererUser> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        initialData: null,
        value: AdminMedcinData().infouser,
        builder: (context, child) {
          final usersFire = Provider.of<QuerySnapshot>(context);
          List users = [], medecins = [], admins = [];

          usersFire.docs.forEach((element) {
            if (element['identif'] == 'utilisateur') {
              users.add(element);
            } else if (element['identif'] == 'médecin') {
              medecins.add(element);
            } else {
              admins.add(element);
            }
          });
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.keyboard_return_outlined),
                color: Colors.blue[900],
              ),
              elevation: 0.5,
              backgroundColor: Colors.grey[100],
              toolbarHeight: 130,
              title: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'Gérer utilisateur',
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 120, vertical: 100),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[200])),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GUser(
                                    myUsers: users,
                                  )));
                        },
                        child: Text(
                          'gérer utilisateur',
                          style: TextStyle(color: Colors.blue[900]),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[200])),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GMedecin(
                                    myMedecins: medecins,
                                  )));
                        },
                        child: Text(
                          'gérer médecin',
                          style: TextStyle(color: Colors.blue[900]),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[200])),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GAdmin(
                                    myAdmins: admins,
                                  )));
                        },
                        child: Text(
                          'gérer administrateur',
                          style: TextStyle(color: Colors.blue[900]),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
