import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';
import 'package:sang_plus_plus/services/auth_service.dart';

class Authentif extends StatefulWidget {
  @override
  _AuthentifState createState() => _AuthentifState();
}

class _AuthentifState extends State<Authentif> {
  final AuthServices _auth = AuthServices();
  String _email, _password;
  bool tt = true;
  bool tf = false;
  bool connection = false;

  var y;

  @override
  Widget build(BuildContext context) {
    int x = tt == true ? 0 : 1;

    Icon eye = Icon(Icons.remove_red_eye);
    Icon hide = Icon(Icons.visibility_off_rounded);

    List<Icon> eyeHide = [eye, hide];

    return connection
        ? CircularLoad()
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/menu'),
                    child: Text(
                      'Passer',
                      style: TextStyle(color: Colors.teal[400]),
                    ))
              ],
              centerTitle: true,
              elevation: 0.5,
              backgroundColor: Colors.grey[100],
              toolbarHeight: 150,
              title: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'Authentification',
                  style: TextStyle(
                      color: Colors.teal[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
            body: Container(
                color: Colors.grey[100],
                padding: EdgeInsets.symmetric(horizontal: 42, vertical: 30),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Text(
                          'c\'est la page d\'inscription pour les administrateur ',
                          style: TextStyle(
                              color: Colors.grey[600], letterSpacing: 0.2),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/authentif'),
                                child: Text(
                                  'S\'authentifier',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal[400],
                                      fontWeight: FontWeight.w600),
                                )),
                            TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/creeCompte'),
                                child: Text(
                                  'Créer Compte',
                                  style: TextStyle(color: Colors.grey),
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            _email = value.trim();
                          },
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400])),
                              hintText: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Colors.teal[400],
                              )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            _password = value;
                          },
                          obscureText: tt,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    y = tt;
                                    tt = tf;
                                    tf = y;
                                  });
                                },
                                icon: eyeHide[x]),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                            hintText: 'Mot de passe',
                            icon: Icon(
                              Icons.lock,
                              color: Colors.teal[400],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/resetpass'),
                          child: Text(
                            'mot de passe oublier ?',
                            style: TextStyle(
                                color: Colors.teal[600], letterSpacing: 1),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: TextButton(
                            onPressed: () async {
                              setState(() => connection = true);
                              dynamic result =
                                  await _auth.signIn(_email, _password);
                              if (result == null) {
                                setState(() {
                                  connection = false;
                                });
                              }
                            },
                            child: Text(
                              'CONNEXION',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.teal[400]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/creeCompte');
                          },
                          child: Text(
                            'S\'inscrire',
                            style: TextStyle(
                                color: Colors.teal[400], fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
  }
}
