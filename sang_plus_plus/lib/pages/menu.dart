import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus/pages/widgets/bottom.dart';
import 'package:sang_plus_plus/pages/widgets/carousel.dart';
import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';

import 'package:sang_plus_plus/pages/widgets/drawer.dart';
import 'package:sang_plus_plus/services/auth_service.dart';
import 'package:sang_plus_plus/services/database.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final AuthServices _auth = AuthServices();
  FirebaseAuth authfire = FirebaseAuth.instance;

  final int indexPage = 0;
  bool disconnect = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return disconnect
        ? CircularLoad()
        : StreamProvider<QuerySnapshot>.value(
            initialData: null,
            value: UserData().events,
            builder: (context, child) {
              List events = [];
              final event = Provider.of<QuerySnapshot>(context);
              event.docs.forEach((element) {
                DateTime dateTime = DateTime.parse(element['date']);
                if (dateTime.isAfter(DateTime.now())) {
                  events.add(element);
                }
              });
              print(events.length);

              return Scaffold(
                backgroundColor: Colors.grey[200],
                drawer: MyDrawer(),
                appBar: AppBar(
                    centerTitle: true,
                    toolbarHeight: 130,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Text(
                        'Sang ++',
                        style: TextStyle(
                            color: Colors.teal[400],
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    backgroundColor: Colors.grey[100],
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.teal[400]),
                    actions: [
                      IconButton(
                        onPressed: user != null
                            ? () {
                                setState(() {
                                  disconnect = true;
                                });
                                _auth.signOut();
                              }
                            : () {
                                Navigator.pushNamed(context, '/authentif');
                              },
                        icon: user != null
                            ? Icon(Icons.logout)
                            : Icon(Icons.login),
                      )
                    ]),
                body: Center(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      MyCaroussel(),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 18),
                        child: Text(
                          'Événement',
                          style: TextStyle(
                              color: Colors.teal[400],
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      event.docs.isEmpty
                          ? Center(
                              child: Text('aucun événement pour le moment'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: event.size,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150,
                                  child: Card(
                                    margin:
                                        EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: ListTile(
                                        onTap: () {},
                                        leading: Container(
                                          width: 100,
                                          height: 100,
                                          child: ClipRect(
                                              child: event.docs[index]
                                                          ['image'] ==
                                                      ''
                                                  ? Image.asset(
                                                      'assets/picture.png')
                                                  : Image.network(
                                                      event.docs[index]
                                                          ['image'],
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                        title: Text(
                                            'Evénement don du sang à :\n${event.docs[index]['lieux']}'),
                                        subtitle:
                                            Text(event.docs[index]['date']),
                                        trailing: null,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
                bottomNavigationBar: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.grey[100],
                  ),
                  child: MyBottom(
                    indexPage: indexPage,
                  ),
                ),
              );
            },
          );
  }
}
