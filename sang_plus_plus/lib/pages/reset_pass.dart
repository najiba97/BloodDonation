import 'package:flutter/material.dart';
import 'package:sang_plus_plus/services/auth_service.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  String _email = '';
  AuthServices _authServices = AuthServices();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 150,
        title: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'Changer mot de passe',
            style: TextStyle(
                color: Colors.teal[400],
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'veuillez ecrire votre email puis appuyer sur le bouton et vous recevrez un lien dans votre email pour changer votre mot de passe.',
                    style: TextStyle(color: Colors.grey[600], letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      _email = value.trim();
                    },
                    validator: (value) =>
                        value.isEmpty ? 'ecrire votre email' : null,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[400])),
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.teal[400],
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _authServices.changePassword(_email);
                          if (result != null) {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Félicitation'),
                                    content: Text(
                                      'un lien de réinitialisation du mot de passe a été envoyé à ' +
                                          _email,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          letterSpacing: 1),
                                    ),
                                    actions: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/authentif');
                                          },
                                          icon: Icon(Icons.login),
                                          label: Text(''))
                                    ],
                                  );
                                });
                          } else {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Dommage'),
                                    content: Text(
                                      'une erreur s\'est produite veuillez verifier votre connexion internet' +
                                          _email,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          letterSpacing: 1),
                                    ),
                                    actions: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/authentif');
                                          },
                                          icon: Icon(Icons.login),
                                          label: Text(''))
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text(
                        'réinitialiser mot de passe',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.teal[400]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
