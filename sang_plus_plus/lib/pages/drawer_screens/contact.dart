import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contacte extends StatefulWidget {
  @override
  _ContacteState createState() => _ContacteState();
}

class _ContacteState extends State<Contacte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('contacter-nous'),
          backgroundColor: Colors.teal[400],
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
          color: Colors.grey[200],
          child: ListView(
            children: [
              SizedBox(
                height: 70,
              ),
              Image.asset('assets/taher sfar.jpg'),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.home),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Hôpital UniversitaireTahar Sfar,\nMahdia 5100',
                      style: TextStyle(fontSize: 21, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '  73 109 000',
                      style: TextStyle(fontSize: 21, color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
