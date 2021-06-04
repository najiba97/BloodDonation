import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/auth_service.dart';

class CreeCompte extends StatefulWidget {
  @override
  _CreeCompteState createState() => _CreeCompteState();
}

class _CreeCompteState extends State<CreeCompte> {
  final formKey = GlobalKey<FormState>();

  final List identif = ['admin', 'medcin'];
  AuthService authService = AuthService();
  bool notIdentified = true;

  String _nom,
      _prenom,
      _email,
      _password,
      _confirmPassword,
      valueChoose,
      _identif = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0.5,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 200,
        title: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'CREE COMPTE',
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
                    'c\'est la page d\'inscription pour les administrateur ',
                    style: TextStyle(color: Colors.grey[600]),
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
                        icon: Icon(Icons.account_circle_rounded)),
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
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                    validator: (value) => value.isEmpty
                        ? 'mot de passe ne peut pas etre vide'
                        : null,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'mot de passe',
                        icon: Icon(Icons.lock)),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
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
                        border: UnderlineInputBorder(),
                        hintText: 'confirmer mot de passe',
                        icon: Icon(Icons.lock)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    hint: Text('profession'),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
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
