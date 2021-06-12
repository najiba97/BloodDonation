import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus_admin/services/auth_service.dart';
import 'package:sang_plus_plus_admin/services/database.dart';
import 'package:sang_plus_plus_admin/widgets/carousel.dart';
import 'package:sang_plus_plus_admin/widgets/circular_load.dart';
import 'package:sang_plus_plus_admin/widgets/weeklychart.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool disconect = false;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    List<Widget> medecinDrawer = [
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('créer évènement'),
        onTap: () {
          Navigator.pushNamed(context, '/create_event');
        },
      ),
      SizedBox(height: 10),
      ListTile(
        leading: Icon(Icons.view_agenda),
        title: Text('gestion rendez_vous'),
        onTap: () {
          Navigator.pushNamed(context, '/gestion_rendezvs');
        },
      ),
      SizedBox(height: 10),
      ListTile(
        leading: Icon(Icons.done_all),
        title: Text('confirmation rendez-vous'),
        onTap: () {
          Navigator.pushNamed(context, '/confirm_rendezvous');
        },
      ),
    ];

    List<Widget> adminDrawer = [];
    return disconect
        ? CircularLoad()
        : StreamProvider<DocumentSnapshot>.value(
            initialData: null,
            value: AdminMedcinData().job,
            builder: (context, child) {
              final identif = Provider.of<DocumentSnapshot>(context);
              return identif['identif'] == 'utilisateur'
                  ? Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Désoler c\'est l\'application serveur !',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 100,
                            height: 45,
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  disconect = true;
                                });
                                await AuthService().signOut();
                              },
                              child: Text(
                                'retourner',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Scaffold(
                      drawer: Drawer(
                        child: ListView(
                          children: [
                            DrawerHeader(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sang++ ',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.blue[900]),
                                  ),
                                  Text(
                                    identif['identif'],
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                              decoration:
                                  BoxDecoration(color: Colors.indigo[50]),
                            ),
                            SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: identif['identif'] == 'medecin'
                                  ? medecinDrawer
                                  : adminDrawer,
                            ),
                          ],
                        ),
                      ),
                      appBar: AppBar(
                        actions: [
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  disconect = true;
                                });

                                await authService.signOut();
                              },
                              icon: Icon(Icons.logout))
                        ],
                        iconTheme: IconThemeData(color: Colors.blue[900]),
                        backgroundColor: Colors.grey[100],
                      ),
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 25),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 21),
                                            blurRadius: 53,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre de donneurs ',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '100',
                                            style: TextStyle(
                                                color: Colors.blue[900],
                                                fontSize: 40,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 0.8,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'nos statistiques',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      WeeklyChart(),
                                      Divider(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'pourcentage de donneurs par sex',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '40%',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue[900]),
                                              ),
                                              Text(
                                                'homme',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue[900]),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '60%',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue[900]),
                                              ),
                                              Text(
                                                'femme',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue[900]),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                MyCaroussel(),
                              ],
                            ),
                          ],
                        ),
                      ));
            },
          );
  }
}
