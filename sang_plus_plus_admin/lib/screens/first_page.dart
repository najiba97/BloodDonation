import 'dart:ui';

import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/admin_medcin.jpg'),
                radius: 150,
              ),
              SizedBox(
                height: 130.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Gérer vos tâches\n quotidiennes',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'bienvenue dans notre application Sang++\nvous pouvez connecter on cliquant sur\ncommnecer',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/auth_admin');
                      },
                      child: Text(
                        'Commencer',
                        style: TextStyle(
                            color: Colors.indigo[900],
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
