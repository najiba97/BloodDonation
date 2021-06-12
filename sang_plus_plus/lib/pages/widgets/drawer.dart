import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus/services/database.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    FirebaseAuth auth = FirebaseAuth.instance;

    return user == null
        ? Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal[200]),
                  child: Column(
                    children: [],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.announcement_outlined,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'A propos',
                        style:
                            TextStyle(fontSize: 16.0, fontFamily: 'PlayFair'),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/propos');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.call,
                        color: Colors.teal,
                      ),
                      title: Text('Contacter nous',
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: 'PlayFair')),
                      onTap: () {
                        Navigator.pushNamed(context, '/contacte');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.access_time_outlined,
                        color: Colors.teal,
                      ),
                      title: Text('Prendre rendez-vous',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PlayfairDisplay-Regular.ttf')),
                      onTap: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Prendre rendez-vous ?'),
                                content: Text(
                                    'pour prendre un rendez-vous il fauts etre connecte , avez-vous un compte?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/authentif');
                                      },
                                      child: Text('oui')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/creeCompte');
                                      },
                                      child: Text('non')),
                                ],
                              );
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.add_alarm,
                        color: Colors.teal,
                      ),
                      title: Text('Consigne après don',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PlayfairDisplay-Regular.ttf')),
                      onTap: () {
                        Navigator.pushNamed(context, '/consigne');
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : StreamProvider<DocumentSnapshot>.value(
            initialData: null,
            value: UserData().userinfo,
            builder: (context, child) {
              final userInf = Provider.of<DocumentSnapshot>(context);
              return Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.teal[200]),
                      child: Column(
                        children: [],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.announcement_outlined,
                            color: Colors.teal,
                          ),
                          title: Text(
                            'A propos',
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'PlayFair'),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/propos');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.call,
                            color: Colors.teal,
                          ),
                          title: Text('Contacter nous',
                              style: TextStyle(
                                  fontSize: 16.0, fontFamily: 'PlayFair')),
                          onTap: () {
                            Navigator.pushNamed(context, '/contacte');
                          },
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('notification')
                              .doc(auth.currentUser.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('loading data please wait....');
                            } else {
                              var document = snapshot.data;
                              return ListTile(
                                leading: Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.teal,
                                ),
                                title: document['date&heure'] == null
                                    ? Text('Prendre rendez-vous',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily:
                                                'PlayfairDisplay-Regular.ttf'))
                                    : Text(
                                        'votre rendez-vous est fixé\nle ${document['date&heure']}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                onTap: () {
                                  if (document['date&heure'] != null) {
                                  } else if (!userInf['demande en cours']) {
                                    Navigator.pushNamed(context, '/rendez');
                                  } else {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(''),
                                            content: Text(
                                                'votre demande est en cours'),
                                          );
                                        });
                                  }
                                },
                              );
                            }
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.add_alarm,
                            color: Colors.teal,
                          ),
                          title: Text('Consigne après don',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'PlayfairDisplay-Regular.ttf')),
                          onTap: () {
                            Navigator.pushNamed(context, '/consigne');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
