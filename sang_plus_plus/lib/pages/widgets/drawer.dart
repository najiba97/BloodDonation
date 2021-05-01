import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink[100]),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/heartbeat.png',
                    width: 250,
                    height: 67,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'sang++',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                leading: Icon(Icons.announcement_outlined),
                title: Text(
                  'A propos',
                  style: TextStyle(fontSize: 16.0, fontFamily: 'PlayFair'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/propos');
                  print('hi $user');
                },
              ),
              ListTile(
                leading: Icon(Icons.call),
                title: Text('Contacter nous',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'PlayFair')),
                onTap: () {
                  Navigator.pushNamed(context, '/contacte');
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time_outlined),
                title: Text('Prendre rendez-vous',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PlayfairDisplay-Regular.ttf')),
                onTap: () {
                  if (user == null) {
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
                                    Navigator.pushNamed(context, '/authentif');
                                  },
                                  child: Text('oui')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/creeCompte');
                                  },
                                  child: Text('non')),
                            ],
                          );
                        });
                  } else {
                    Navigator.pushNamed(context, '/rendez');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.add_alarm),
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
  }
}
