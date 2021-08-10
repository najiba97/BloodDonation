import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

import 'confirm_perso.dart';

class ConfirmerRendezVous extends StatefulWidget {
  @override
  _ConfirmerRendezVousState createState() => _ConfirmerRendezVousState();
}

class _ConfirmerRendezVousState extends State<ConfirmerRendezVous> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: AdminMedcinData().date,
      builder: (context, child) {
        DateTime dateTime = DateTime.now(), time;

        final appointmentInfo = Provider.of<QuerySnapshot>(context);

        List rendezNonConfirmer = [];

        appointmentInfo.docs.forEach((element) {
          time = DateTime.parse(element['date'].toString());
          if (element['confirmed'] == false) {
            rendezNonConfirmer.add(element);
          }
          if (time.isBefore(dateTime.add(Duration(hours: 1, minutes: 1)))) {
            rendezNonConfirmer.remove(element);
            AdminMedcinData().reUpdateNotif(element['uid']);
          }
        });

        return rendezNonConfirmer.isEmpty
            ? Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.keyboard_return_outlined),
                    color: Colors.blue[900],
                  ),
                  elevation: 0.5,
                  backgroundColor: Colors.grey[100],
                  toolbarHeight: 200,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      'Confirmation rendez-vous',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                body: Center(
                  child: Text('aucun rendez-vous a confirmer'),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.keyboard_return_outlined),
                    color: Colors.blue[900],
                  ),
                  elevation: 0.5,
                  backgroundColor: Colors.grey[100],
                  toolbarHeight: 200,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      'Confirmation rendez-vous',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                body: ListView.builder(
                    itemCount: rendezNonConfirmer.length,
                    itemBuilder: (context, index) {
                      DateTime date =
                          DateTime.parse(rendezNonConfirmer[index]['date']);
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConfirmPerso(
                                        index: index,
                                        donorsInfo: rendezNonConfirmer,
                                      )));
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                  'assets/images/blood-donation.png'),
                            ),
                            title: Text(
                                ' ${rendezNonConfirmer[index]['nom&prénomDonneur']}'),
                            subtitle: Text(
                                '${date.day}/${date.month}/${date.year} à ${date.hour}:${date.minute}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                AdminMedcinData().deleteRendezVous(
                                    rendezNonConfirmer[index]['uid']);
                                AdminMedcinData().reUpdateNotif(
                                    rendezNonConfirmer[index]['uid']);
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              );
      },
    );
  }
}
