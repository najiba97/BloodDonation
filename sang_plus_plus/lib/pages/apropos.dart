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
        appBar: AppBar(
          title: Text('a propos'),
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.red[100], Colors.red[300]]),
          ),
        ));
  }
}
