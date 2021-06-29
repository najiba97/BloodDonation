import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/auth_service.dart';

class CreeCompte extends StatefulWidget {
  @override
  _CreeCompteState createState() => _CreeCompteState();
}

class _CreeCompteState extends State<CreeCompte> {
  final formKey = GlobalKey<FormState>();

  final List identif = ['administrateur', 'médecin'];
  AuthService authService = AuthService();
  bool notIdentified = true;

  String _nom,
      _prenom,
      _email,
      _password,
      _confirmPassword,
      valueChoose,
      _identif = '';
  bool tt = true, tf = false, ttc = true, tfc = false;

  @override
  Widget build(BuildContext context) {
    int x = tt == true ? 0 : 1;
    int z = ttc == true ? 0 : 1;

    Icon eye = Icon(Icons.remove_red_eye);
    Icon hide = Icon(Icons.visibility_off_rounded);

    List<Icon> eyeHide = [eye, hide];
    var y;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        elevation: 0.5,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 130,
        title: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'CRÉE COMPTE',
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
            Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'dans cette page vous pouvez créer une demande si vous êtes medecin ou administrateur.',
                    style: TextStyle(color: Colors.grey[600], letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/auth_admin'),
                          child: Text(
                            'S\'inscrire',
                            style: TextStyle(color: Colors.grey),
                          )),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/cree_compte'),
                          child: Text(
                            'cree compte',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blue[900]),
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
                      _nom = value.trim();
                    },
                    validator: (value) =>
                        value.isEmpty ? 'nom ne peut pas etre vide' : null,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'nom',
                        icon: Icon(Icons.account_circle_rounded)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      _prenom = value.trim();
                    },
                    validator: (value) => value.isEmpty
                        ? 'le prenom ne peut pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'prénom',
                        icon: Icon(Icons.account_circle_outlined)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      _email = value.trim();
                    },
                    validator: (value) =>
                        value.isEmpty ? 'email ne peut pas etre vide' : null,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'email',
                        icon: Icon(Icons.email)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: tt,
                    onChanged: (value) {
                      _password = value;
                    },
                    validator: (value) => value.isEmpty
                        ? 'mot de passe ne peut pas etre vide'
                        : null,
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
                        border: UnderlineInputBorder(),
                        hintText: 'mot de passe',
                        icon: Icon(Icons.lock)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: ttc,
                    onChanged: (value) {
                      _confirmPassword = value;
                    },
                    validator: (String value) {
                      String erreur;
                      if (value.isEmpty) {
                        erreur = 'ce champ ne peut pas etre vide';
                      } else if (_password != _confirmPassword) {
                        erreur = 'n\'est pas identique au mot de passe';
                      }
                      return erreur;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                y = ttc;
                                ttc = tfc;
                                tfc = y;
                              });
                            },
                            icon: eyeHide[z]),
                        border: UnderlineInputBorder(),
                        hintText: 'confirmer mot de passe',
                        icon: Icon(Icons.lock_open_sharp)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    hint: Text('métier'),
                    value: valueChoose,
                    onChanged: (value) {
                      setState(() {
                        valueChoose = value;
                        _identif = value;
                      });
                    },
                    items: identif.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text(valueItem),
                        value: valueItem,
                      );
                    }).toList(),
                  ),
                  notIdentified
                      ? Text('')
                      : Text(
                          'ce champ est obligatoire',
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState.validate() && _identif != '') {
                          await authService.createAcount(
                              _nom, _prenom, _email, _password, _identif);
                        } else {
                          setState(() {
                            notIdentified = false;
                          });
                        }
                      },
                      child: Text(
                        'S\'INSCRIRE',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[900])),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
