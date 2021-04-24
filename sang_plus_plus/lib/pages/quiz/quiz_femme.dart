import 'package:flutter/material.dart';

class QuizFemme extends StatefulWidget {
  @override
  _QuizFemmeState createState() => _QuizFemmeState();
}

class _QuizFemmeState extends State<QuizFemme> {
  int x = 0;
  List<String> img = [
    'family.png',
    'body-scale.png',
    'woman.png',
    'calendar.png',
    'virus.png',
    'needle.png',
    'cancer.png',
    'capsules.png',
    'iron.png',
    'heartbeat.png',
    'thermometer.png',
    'doctor.png',
    'anchor.png',
    'tooth.png',
    'blood-bag.png',
    'passport.png',
    'operating-room.png',
    'medicament.png'
  ];
  List<String> txt = [
    'Avez-vous moins de 18 ans ou plus de 70 ans ?',
    'Pesez vous moins de 50kg ?',
    'Etes-vous enceinte ou avez-vous accouché \n                depuis moins de 6 mois ?',
    'Avez-vous donner votre sang il y a moins de 8\n                                  semaines ?',
    'Avez-vous été testée positif pour le VIH (sida) ?',
    'Avez-vous déjà pris des drogues par voie \n                       intraveineuse ?',
    'Avez-vous été traitée au cours de votre vie pour \n                              un cancer ?',
    'Etes-vous traitée pour une maladie chronique ?',
    'Etes-vous suivie par votre medcin pour une \n           anémie ou un manque de fer ?',
    'Avez-vous ressenti dans les semaines précédentes \n      une douleur thoracique ou un essoufflement\n               inormale à la suite d\'un effort ?',
    'Avez-vous eu de la fièvre ou une infection\n         dans les 2 dernieres semaines ?',
    'Avez-vous subi une fibroscopie gastrique pulmonaire\n       ou une closcopie dans les 4 derniers mois ?',
    'Avez-vous eu un piercing ou un tatouage dans les\n                                4 derniers mois',
    'Avez-vous eu des soins dentaires depuis moins de\n                                     24 heures',
    'Avez-vous déjà eu une transfusion de sang ou une\n                            greffe d\'organe',
    'Avez-vous voyagé dans les 4 derniers mois ?',
    'Avez-vous été opérée dans les 4 derniers mois ?',
    'Prenez-vous des médicaments ?'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[150],
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      if (x > 0) {
                        setState(() {
                          x--;
                        });
                      }
                    },
                    icon: Icon(Icons.keyboard_return)),
              ],
            ),
            SizedBox(
              height: 100.0,
            ),
            Center(
              child: Image.asset(
                'assets/${img[x]}',
                width: 200.0,
              ),
            ),
            SizedBox(height: 40.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  '${txt[x]}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'oui',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.white))))),
                SizedBox(width: 40),
                TextButton(
                    onPressed: () {
                      if (x < img.length - 1) {
                        setState(() {
                          x++;
                        });
                      }
                    },
                    child: Text(
                      'non',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.white))))),
              ],
            ),
            SizedBox(height: 40.0),
            Text(
              '${x + 1}/18',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            )
          ]),
        ));
  }
}
