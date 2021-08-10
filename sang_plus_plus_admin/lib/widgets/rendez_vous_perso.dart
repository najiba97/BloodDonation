import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus_admin/services/database.dart';
import 'package:sang_plus_plus_admin/widgets/accept.dart';

class RendezPerso extends StatelessWidget {
  int index = 0;
  AdminMedcinData adminMedcinData = AdminMedcinData();

  RendezPerso({this.index});

  @override
  Widget build(BuildContext context) {
    final rendez = Provider.of<QuerySnapshot>(context);

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 100),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Nom : '),
                  Text(
                    rendez.docs[index]['nom'],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Prénom : '),
                  Text(
                    rendez.docs[index]['prénom'],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Date de naissance : '),
                  Text(
                    rendez.docs[index]['date'],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('email : '),
                  Text(
                    rendez.docs[index]['email'],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Téléphone : '),
                  Text(
                    rendez.docs[index]['téléphone'],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('groupe sanguin : '),
                  Text(
                    rendez.docs[index]['groupe sanguin'],
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Accept(
                                  index: index,
                                )));
                      },
                      child: Text('accepter')),
                  SizedBox(
                    width: 50,
                  ),
                  TextButton(
                      onPressed: () async {
                        adminMedcinData
                            .effacerRendez(rendez.docs[index]['uid']);
                        adminMedcinData.demandeRecu(rendez.docs[index]['uid']);

                        Navigator.pop(context);
                      },
                      child: Text(
                        'refuser',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
