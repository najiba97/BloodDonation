import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/auth_service.dart';
import 'package:sang_plus_plus_admin/widgets/circular_load.dart';

class AuthAdmin extends StatefulWidget {
  @override
  _AuthAdminState createState() => _AuthAdminState();
}

class _AuthAdminState extends State<AuthAdmin> {
  AuthService authService = AuthService();

  String email, password;

  bool disconnect = false;
  bool tt = true;
  bool tf = false;

  @override
  Widget build(BuildContext context) {
    int x = tt == true ? 0 : 1;

    Icon eye = Icon(Icons.remove_red_eye);
    Icon hide = Icon(Icons.visibility_off_rounded);

    List<Icon> eyeHide = [eye, hide];
    var y;

    return disconnect
        ? CircularLoad()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.keyboard_return_outlined),
                color: Colors.blue[900],
              ),
              elevation: 0.5,
              backgroundColor: Colors.grey[100],
              toolbarHeight: 130,
              title: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'Authentification',
                  style: TextStyle(
                      color: Colors.blue[900],
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
                          'c\'est la page d\'inscription pour les administrateurs et les médecins ',
                          style: TextStyle(
                              color: Colors.grey[600], letterSpacing: 1),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'S\'authentifier',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blue[900]),
                                )),
                            TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/cree_compte'),
                                child: Text(
                                  'Créer un Compte',
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
                          onChanged: (val) {
                            email = val.trim();
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'Email',
                              icon: Icon(Icons.email)),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          obscureText: tt,
                          onChanged: (val) {
                            password = val;
                          },
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
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Mot de passe',
                              icon: Icon(Icons.lock)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/passe');
                            },
                            child: Text(
                              'mot de passe oublier ?',
                              style: TextStyle(color: Colors.blue[900]),
                            )),
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 35,
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                disconnect = true;
                              });
                              dynamic result =
                                  await authService.signIn(email, password);
                              if (result == null) {
                                setState(() {
                                  disconnect = false;
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
                                  MaterialStateProperty.all(Colors.blue[900]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
  }
}
