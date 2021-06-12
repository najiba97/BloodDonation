import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus_admin/widgets/rendez_vous_perso.dart';

class ListRendez extends StatefulWidget {
  ListRendez({Key key}) : super(key: key);

  @override
  _ListRendezState createState() => _ListRendezState();
}

class _ListRendezState extends State<ListRendez> {
  @override
  Widget build(BuildContext context) {
    final rendez = Provider.of<QuerySnapshot>(context);

    return ListView.builder(
        itemCount: rendez.size,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RendezPerso(
                            index: index,
                          )));
                },
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/images/blood-donation.png'),
                ),
                title: Text(
                    ' ${rendez.docs[index]['nom']} ${rendez.docs[index]['prénom']}'),
                subtitle: Text(rendez.docs[index]['groupe sanguin']),
              ),
            ),
          );
        });
  }
}
