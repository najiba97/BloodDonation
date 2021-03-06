import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/database.dart';
import 'package:sang_plus_plus_admin/widgets/circular_load.dart';

class ConfirmPerso extends StatefulWidget {
  int index = 0;
  List donorsInfo = [];

  ConfirmPerso({this.index, this.donorsInfo});

  @override
  _ConfirmPersoState createState() => _ConfirmPersoState();
}

class _ConfirmPersoState extends State<ConfirmPerso> {
  String valueChoose, vCh, erreur = '', erreurOne = '';
  AdminMedcinData adminMedcinData = AdminMedcinData();

  List listGroupeSanguin = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String sexe = '', gs = '', nom = '';

  List listSexe = ['homme', 'femme'];
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return done
        ? CircularLoad()
        : Scaffold(
            body: ListView(
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 100),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            adminMedcinData.updateInfo('nom&prénomDonneur',
                                value, widget.donorsInfo[widget.index]['uid']);
                          },
                          decoration: InputDecoration(
                              hintText: widget.donorsInfo[widget.index]
                                  ['nom&prénomDonneur']),
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
                              gs = value;
                            });
                          },
                          items: listGroupeSanguin.map((valueItem) {
                            return DropdownMenuItem(
                              child: Text(valueItem),
                              value: valueItem,
                            );
                          }).toList(),
                        ),
                        Text(
                          erreur,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton(
                          hint: Text('sexe'),
                          value: vCh,
                          onChanged: (value) {
                            setState(() {
                              vCh = value;
                              sexe = value;
                            });
                          },
                          items: listSexe.map((valueItem) {
                            return DropdownMenuItem(
                              child: Text(valueItem),
                              value: valueItem,
                            );
                          }).toList(),
                        ),
                        Text(
                          erreurOne,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.teal[400],
                          onPressed: () async {
                            if (gs == '') {
                              setState(() {
                                erreur =
                                    'le champ confirmer groupe sanguin est obligatoire';
                              });
                            } else if (sexe == '') {
                              setState(() {
                                erreurOne =
                                    'le champ confirmer sexe est obligatoire';
                              });
                            } else {
                              setState(() {
                                done = true;
                              });
                              await adminMedcinData.confirmGsSex(sexe, gs,
                                  widget.donorsInfo[widget.index]['uid']);
                              await adminMedcinData.reUpdateNotif(
                                  widget.donorsInfo[widget.index]['uid']);
                              await adminMedcinData.updateStat(
                                  'nombreTotale', 1);
                              await adminMedcinData.updateStat(gs, 1);
                              await adminMedcinData.updateStat(sexe, 1);
                              Navigator.pop(context);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          '${widget.donorsInfo[widget.index]['nom&prénomDonneur']} est confirmer comme donneur'),
                                    );
                                  });
                            }
                          },
                          child: Icon(Icons.done),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
