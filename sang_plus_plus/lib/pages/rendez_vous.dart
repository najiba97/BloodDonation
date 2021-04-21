import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Rendez extends StatefulWidget {
  @override
  _RendezState createState() => _RendezState();
}

class _RendezState extends State<Rendez> {
  final formKey = GlobalKey<FormState>();

  TextEditingController dateCtl = TextEditingController();
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Rendez-vous'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/menu');
              },
              icon: Icon(Icons.home),
              splashColor: Colors.green,
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Pour donner son sang il faut avoir entre 18 et 70 et peser au moins 50 kg.',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'nom ne peut pas etre vide';
                            }
                            return '';
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Nom',
                              labelStyle: TextStyle(fontSize: 16),
                              hintText: ('ecrire votre nom'))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'prénom ne peut pas etre vide';
                            }
                            return '';
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'prénom',
                              labelStyle: TextStyle(fontSize: 16),
                              hintText: ('ecrire votre prénom'))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email ne peut pas etre vide';
                            }
                            return '';
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 16),
                              hintText: ('ecrire votre email'))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'numéro de téléphone ne peut pas etre vide';
                            }
                            return '';
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'numéro de téléphone',
                              labelStyle: TextStyle(fontSize: 16),
                              hintText: ('ecrire votre numéro de téléphone'))),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'date de n\'aissance ne peut pas etre vide';
                          }
                          return '';
                        },
                        controller: dateCtl,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: "date de naissance",
                          labelStyle: TextStyle(fontSize: 16),
                          hintText: "date",
                        ),
                        onTap: () async {
                          DateTime date = DateTime(1900);
                          FocusScope.of(context).requestFocus(new FocusNode());

                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime(1997),
                              firstDate: DateTime(dateTime.year - 69),
                              lastDate: DateTime(dateTime.year - 18));
                          if (date != null) {
                            dateCtl.text = DateFormat.yMd().format(date);
                          }
                        },
                      )
                    ],
                  ),
                )),
            FloatingActionButton(
              onPressed: () {
                formKey.currentState.validate();
              },
              child: Icon(Icons.done),
            )
          ],
        ));
  }
}
