import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    /* l'instance auth de firebase va nous donner l'etat de user null ou pas
    par la methode authStateChanges.listen((User use)) */
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        Timer(Duration(seconds: 3), () {
          Navigator.pushNamed(context, '/authentif');
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.pushNamed(context, '/menu');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: SpinKitPumpingHeart(
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );
  }
}
