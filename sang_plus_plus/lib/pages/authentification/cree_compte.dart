import 'package:flutter/material.dart';
import 'package:sang_plus_plus/pages/services/auth_service.dart';
import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';

class CreateCount extends StatefulWidget {
  @override
  _CreateCountState createState() => _CreateCountState();
}

class _CreateCountState extends State<CreateCount> {
  AuthServices _auth = AuthServices();
  String _password, _email, _nom, _prenom, _tel, _confirmPassword;

  bool tt = true, tf = false, ttc = true, tfc = false;
  var y;
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool connection = false;
  @override
  Widget build(BuildContext context) {
    int x = tt == true ? 0 : 1;
    int z = ttc == true ? 0 : 1;

    Icon eye = Icon(Icons.remove_red_eye);
    Icon hide = Icon(Icons.visibility_off_rounded);
    List<Icon> hideEye = [eye, hide];

    return connection
        ? CircularLoad()
        : Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/sang.jfif'),
                        fit: BoxFit.cover)),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/heartbeat.png',
                              height: 120.0,
                              width: 120.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _nom = value;
                                });
                              },
                              validator: (value) => value.isEmpty
                                  ? 'nom ne peut pas étre vide'
                                  : null,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'NOM',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) => value.isEmpty
                                  ? 'prénom ne peut pas étre vide'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _prenom = value;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'PRENOM',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) => value.isEmpty
                                  ? 'email ne peut pas étre vide'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'EMAIL',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) => value.isEmpty
                                  ? 'numéro ne peut pas étre vide'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _tel = value;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'NUMERO DE TELEPHONE',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) => value.isEmpty
                                  ? 'mot de passe ne peut pas étre vide'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
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
                                      icon: hideEye[x]),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'MOT DE PASSE',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (String value) {
                                String errors;
                                if (value.isEmpty) {
                                  errors =
                                      'mots de passe ne peut pas etre vide';
                                } else if (_password != _confirmPassword) {
                                  errors = 'mot de passe non identique';
                                }
                                return errors;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _confirmPassword = value;
                                });
                              },
                              obscureText: ttc,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        y = ttc;
                                        ttc = tfc;
                                        tfc = y;
                                      });
                                    },
                                    icon: hideEye[z],
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'CONFIRMER MOT DE PASSE',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                  icon: Icon(
                                    Icons.lock_open_sharp,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate() ==
                                      true) {
                                    setState(() {
                                      connection = true;
                                    });
                                    dynamic result = await _auth.createAccount(
                                        _nom, _prenom, _tel, _email, _password);
                                    if (result == null) {
                                      connection = false;
                                      setState(() {
                                        error = 'connection non aboutie';
                                      });
                                      print(error);
                                    }
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  child: Text(
                                    'S\'INSCRIRE',
                                    style: TextStyle(
                                      color: Colors.red[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            side: BorderSide(
                                                color: Colors.white))))),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, '/authentif');
                              },
                              child: Text(
                                'J\'ai déjà un compte',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
  }
}
