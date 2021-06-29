import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus_admin/widgets/list_rendez.dart';

class GestionRendezVous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rendez = Provider.of<QuerySnapshot>(context);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/menu'),
            icon: Icon(Icons.keyboard_return_outlined),
            color: Colors.blue[900],
          ),
          elevation: 0.5,
          backgroundColor: Colors.grey[100],
          toolbarHeight: 200,
          title: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              'Gestion rendez-vous',
              style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ),
        body: rendez.docs.isEmpty
            ? Center(child: Text('aucun rendez vous'))
            : ListRendez());
  }
}
