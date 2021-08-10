import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Propos extends StatefulWidget {
  @override
  _ProposState createState() => _ProposState();
}

class _ProposState extends State<Propos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('a propos'),
        backgroundColor: Colors.teal[400],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/menu');
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            splashColor: Colors.green,
          )
        ],
      ),
      body: Column(children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/tahardfarlogo.jpg'),
            ),
          ),
        ),
        SizedBox(
          height: 35.0,
        ),
        Text(
          'Application "sang_plus_plus" de EPS Tahar Sfar \nl\'hopital universitaire de mahdia.',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 35.0,
        ),
        Text(
          'version 1.0.0',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}
