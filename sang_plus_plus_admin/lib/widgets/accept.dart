import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus_admin/services/database.dart';
import 'package:intl/intl.dart';

class Accept extends StatefulWidget {
  int index = 0;
  Accept({this.index});

  @override
  _AcceptState createState() => _AcceptState();
}

class _AcceptState extends State<Accept> {
  TextEditingController dateCtl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String date, heure = '', erreur = '', dateHeure = '';

  bool sameAppointment = false;
  AdminMedcinData adminMedcinData = AdminMedcinData();
  dynamic dateH;

  DateTime dateTime = DateTime.now();
  List heureRendez = [
    '08:00 AM',
    '08:30 AM',
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '13:00 PM',
    '13:30 PM',
    '14:00 PM',
    '14:30 PM',
    '15:00 PM',
    '15:30 PM',
    '16:00 PM',
    '16:30 PM',
    '17:00 PM',
    '17:30 PM',
    '21:06 PM',
  ];
  String valueChoose;
  String time = '';

  @override
  Widget build(BuildContext context) {
    final rendez = Provider.of<QuerySnapshot>(context);
    return StreamProvider<QuerySnapshot>.value(
        value: AdminMedcinData().date,
        initialData: null,
        builder: (context, child) {
          final rendezDate = Provider.of<QuerySnapshot>(context);

          return Scaffold(
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            'Donner la date et l\'heure',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: dateCtl,
                            validator: (value) => value.isEmpty
                                ? 'date ne peut pas etre vide'
                                : null,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Date',
                                labelStyle: TextStyle(fontSize: 16),
                                hintText: ('ecrire date')),
                            onTap: () async {
                              DateTime myDate = DateTime(1900);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              myDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(dateTime.year + 1));
                              if (myDate != null) {
                                dateCtl.text = DateFormat.yMd().format(myDate);
                                String month =
                                    myDate.month.toString().length == 1
                                        ? '0${myDate.month}'
                                        : myDate.month.toString();
                                String day = myDate.day.toString().length == 1
                                    ? '0${myDate.day}'
                                    : myDate.day.toString();
                                time = '${myDate.year}-$month-$day';
                                print(time);
                              }
                              setState(() {
                                date = dateCtl.text;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButton(
                            hint: Text('choisir l\'heure'),
                            value: valueChoose,
                            onChanged: (value) {
                              setState(() {
                                valueChoose = value;
                                heure = value;
                              });

                              rendezDate.docs.forEach((element) {
                                if (dateH == element['date don']) {
                                  sameAppointment = true;
                                } else {
                                  sameAppointment = false;
                                }
                              });
                            },
                            items: heureRendez.map((valueItem) {
                              return DropdownMenuItem(
                                child: Text(valueItem),
                                value: valueItem,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            erreur,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          FloatingActionButton(
                            backgroundColor: Colors.blue[900],
                            onPressed: () async {
                              if (sameAppointment) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            'la date de rendez vous ($dateH) est pris'),
                                        content: Text(
                                            'choisir une autre date s\'il vous plait'),
                                      );
                                    });
                              } else if (formKey.currentState.validate() ==
                                      true &&
                                  heure != '') {
                                dateH = date + ' à ' + heure;
                                time += ' ${heure.split(' ')[0]}';
                                await adminMedcinData.updateNotif(
                                    dateH, rendez.docs[widget.index]['uid']);
                                await adminMedcinData.demandeRecu(
                                    rendez.docs[widget.index]['uid']);
                                await adminMedcinData.createDateRendezVous(
                                  dateH,
                                  rendez.docs[widget.index]['nom'],
                                  rendez.docs[widget.index]['prénom'],
                                  rendez.docs[widget.index]['sexe'],
                                  rendez.docs[widget.index]['groupe sanguin'],
                                  rendez.docs[widget.index]['uid'],
                                  time,
                                );
                                await adminMedcinData.dateDon(
                                    time, rendez.docs[widget.index]['uid']);
                                await adminMedcinData.effacerRendez(
                                    rendez.docs[widget.index]['uid']);
                                Navigator.pushNamed(
                                    context, '/gestion_rendezvs');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            'votre notification a été envoyé avec succès'),
                                      );
                                    });
                              } else {
                                setState(() {
                                  erreur = 'l\'heure ne peut pas être vide';
                                });
                              }
                            },
                            child: Icon(Icons.done),
                          ),
                        ],
                      )),
                )
              ],
            ),
          );
        });
  }
}
