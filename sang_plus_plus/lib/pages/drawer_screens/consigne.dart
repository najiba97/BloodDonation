import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Consigne extends StatefulWidget {
  @override
  _ConsigneState createState() => _ConsigneState();
}

class _ConsigneState extends State<Consigne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('consigne aprés don'),
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
        child: (ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/pansement.jpg',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '  Conserver au minimum 2 heures après le don le bandage légerement compressif fait sue le point de ponction pour éviter la formation dun hématome.',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset('assets/sport.jpg'),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '  Eviter de pratiquer un sport de facon intense aprés votre don  un délai de 48 heures est nécessaire avant et aprés le don pour la plongée sous-marine, lesclade et toute compétition.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset('assets/eau.jpg'),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '  Buvez en suffisance: le volume donné est remplacé le jour meme et votre taux de globule rouges reviendra a la normale dans des trois semaines.\n\n',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          ],
        )),
      ),
    );
  }
}
