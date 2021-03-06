import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';

import 'package:sang_plus_plus/services/database.dart';

class Rendez extends StatefulWidget {
  @override
  _RendezState createState() => _RendezState();
}

class _RendezState extends State<Rendez> {
  final formKey = GlobalKey<FormState>();

  TextEditingController dateCtl = TextEditingController();
  DateTime dateTime = DateTime.now();
  int selectedRadio = 0;
  String valueChoose = '';
  List listItem = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String _email = '', _nom = '', _prenom = '', _tel = '', _sexe = 'inconnu', _gs = 'inconnu', _date = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool load = false;

  void setRadioValue(value) {
    setState(() {
      selectedRadio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _uid = _auth.currentUser.uid;
    return load
        ? CircularLoad()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text('Rendez-vous'),
              centerTitle: true,
              backgroundColor: Colors.teal[400],
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/menu ');
                  },
                  icon: Icon(Icons.home),
                  splashColor: Colors.green,
                )
              ],
            ),
            body: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            'Pour donner son sang il faut avoir entre 18 et 70 et peser au moins 50 kg.',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _nom = value;
                                });
                              },
                              validator: (value) => value.isEmpty
                                  ? 'nom ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Nom (ce champ est obligatoire)',
                                  labelStyle: TextStyle(fontSize: 16),
                                  hintText: ('ecrire votre nom '))),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _prenom = value;
                                });
                              },
                              validator: (value) => value.isEmpty
                                  ? 'pr??nom ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText:
                                      'Pr??nom (ce champ est obligatoire)',
                                  labelStyle: TextStyle(fontSize: 16),
                                  hintText: ('ecrire votre pr??nom'))),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              validator: (value) => value.isEmpty
                                  ? 'email ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Email (ce champ est obligatoire)',
                                  labelStyle: TextStyle(fontSize: 16),
                                  hintText: ('ecrire votre email'))),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                setState(() {
                                  _tel = value;
                                });
                              },
                              validator: (value) => value.isEmpty
                                  ? 'telephone ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText:
                                      'num??ro de t??l??phone : (ce champ est obligatoire)',
                                  labelStyle: TextStyle(fontSize: 16),
                                  hintText:
                                      ('ecrire votre num??ro de t??l??phone'))),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) => value.isEmpty
                                ? 'date ne peut pas etre vide'
                                : null,
                            controller: dateCtl,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText:
                                  "date de naissance (ce champ est obligatoire)",
                              labelStyle: TextStyle(fontSize: 16),
                              hintText: "date",
                            ),
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(dateTime.year - 18),
                                  firstDate: DateTime(dateTime.year - 69),
                                  lastDate: DateTime(dateTime.year - 18));
                              if (date != null) {
                                dateCtl.text = DateFormat.yMd().format(date);
                              }

                              _date = dateCtl.text;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButton(
                            hint: Text('groupe sanguin'),
                            value: valueChoose,
                            onChanged: (value) {
                              setState(() {
                                valueChoose = value;
                                _gs = value;
                              });
                            },
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem(
                                child: Text(valueItem),
                                value: valueItem,
                              );
                            }).toList(),
                          ),
                          RadioListTile(
                            title: Text('homme'),
                            value: 1,
                            groupValue: selectedRadio,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setRadioValue(value);
                              setState(() {
                                _sexe = 'homme';
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text('femme'),
                            value: 2,
                            groupValue: selectedRadio,
                            activeColor: Colors.pink[400],
                            onChanged: (value) {
                              setRadioValue(value);
                              _sexe = 'femme';
                            },
                          ),
                        ],
                      ),
                    )),
                FloatingActionButton(
                  backgroundColor: Colors.teal[400],
                  onPressed: () async {
                    if (formKey.currentState.validate() == true) {
                      setState(() {
                        load = true;
                      });
                      await UserData(uid: _uid).prendreRendezVous(
                          _nom, _prenom, _email, _tel, _date, _sexe, _gs);

                      await UserData().demandeEnvoyer();

                      Navigator.pop(context);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('votre demande a ??t?? bien re??ue'),
                            );
                          });
                    }
                  },
                  child: Icon(Icons.done),
                ),
              ],
            ));
  }
}
