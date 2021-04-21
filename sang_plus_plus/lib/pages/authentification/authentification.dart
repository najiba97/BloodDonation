import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sang_plus_plus/pages/services/auth_service.dart';
import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';

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
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/sang.jfif'),
                        fit: BoxFit.cover)),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/creeCompte');
                            },
                            child: Text(
                              'S\'INSCRIRE',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/heartbeat.png',
                            height: 120.0,
                            width: 120.0,
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                this._email = value;
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: 'TELEPHONE OU EMAIL',
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
                            height: 20.0,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                this._password = value;
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
                                  icon: eyeHide[x]),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: 'MOT DE PASSE',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 90.0,
                          ),
                          TextButton(
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                child: Text(
                                  'CONNEXION',
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
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/menu');
                                },
                                child: Text(
                                  'PASSER',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
  }
}
