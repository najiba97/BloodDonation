import 'package:flutter/material.dart';

import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';
import 'package:sang_plus_plus/services/auth_service.dart';

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
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.5,
              backgroundColor: Colors.grey[100],
              toolbarHeight: 130,
              title: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'CRÉE COMPTE',
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'Dans cette page vous pouvez créer un compte et devenir donneur.',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/authentif'),
                                  child: Text(
                                    'S\'authentifier',
                                    style: TextStyle(color: Colors.grey),
                                  )),
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/creeCompte'),
                                  child: Text(
                                    'Crée compte',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.teal[400],
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                          Divider(
                            thickness: 4,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              _nom = value;
                            },
                            validator: (value) => value.isEmpty
                                ? 'nom ne peut pas étre vide'
                                : null,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                hintText: 'Nom',
                                hintStyle: TextStyle(),
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.teal[400],
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
                              _prenom = value;
                            },
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                hintText: 'Prénom',
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.teal[400],
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
                              _email = value;
                            },
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                hintText: 'Email',
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.teal[400],
                                )),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) => value.isEmpty
                                ? 'numéro ne peut pas étre vide'
                                : null,
                            onChanged: (value) {
                              _tel = value;
                            },
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                hintText: 'Numéro de téléphone',
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.teal[400],
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
                                    icon: hideEye[x]),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                hintText: 'Mot de passe',
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.teal[400],
                                )),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            validator: (String value) {
                              String errors;
                              if (value.isEmpty) {
                                errors = 'mots de passe ne peut pas etre vide';
                              } else if (_password != _confirmPassword) {
                                errors = 'mot de passe non identique';
                              }
                              return errors;
                            },
                            onChanged: (value) => _confirmPassword = value,
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
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]),
                                ),
                                hintText: 'Confirmer mot de passe',
                                icon: Icon(
                                  Icons.lock_open_sharp,
                                  color: Colors.teal[400],
                                )),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate() == true) {
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
                                  }
                                }
                              },
                              child: Text(
                                'S\'INSCRIRE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.teal[400])),
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
  }
}
