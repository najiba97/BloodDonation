import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus/services/database.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                                    'pour prendre un rendez-vous il fauts étre connecte , avez-vous un compte?'),
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
              DateTime date;
              if (userInf['date don'] != null) {
                date = DateTime.parse(userInf['date don']);
              }
              print(DateTime.now());

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
                        ListTile(
                          leading: Icon(
                            Icons.access_time_outlined,
                            color: Colors.teal,
                          ),
                          title: userInf['date don'] != null &&
                                  date.isAfter(DateTime.now()
                                      .add(Duration(hours: 1, minutes: 1)))
                              ? Text(
                                  'votre rendez-vous est fixé\nle ${date.day}/${date.month}/${date.year} à ${date.hour}:${date.minute}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text('Prendre rendez-vous',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily:
                                          'PlayfairDisplay-Regular.ttf')),
                          onTap: () {
                            if (userInf['date don'] != null &&
                                date.isAfter(DateTime.now()
                                    .add(Duration(hours: 1, minutes: 1)))) {
                            } else if (userInf['demande en cours'] == false) {
                              Navigator.pushNamed(context, '/rendez');
                            } else {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(''),
                                      content:
                                          Text('votre demande est en cours'),
                                    );
                                  });
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
