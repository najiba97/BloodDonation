import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    firebaseAuth.authStateChanges().listen((User user) {
      if (user != null) {
        Timer(Duration(seconds: 3), () {
          Navigator.pushNamed(context, '/menu');
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.pushNamed(context, '/auth_admin');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitDualRing(
        color: Colors.black,
        size: 150.0,
      ),
    ));
  }
}
