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
        body: Container(
          color: Colors.grey[200],
        ));
  }
}
