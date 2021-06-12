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
        : Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 150,
                title: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    'Sang++',
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
                    icon: user != null ? Icon(Icons.logout) : Icon(Icons.login),
                  )
                ]),
            body: Center(
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        MyCaroussel(),
                      ],
                    ),
                  ),
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
  }
}
