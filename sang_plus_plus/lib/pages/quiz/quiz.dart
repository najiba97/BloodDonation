import 'package:flutter/material.dart';
import 'package:sang_plus_plus/pages/widgets/bottom.dart';
import 'package:sang_plus_plus/services/bottomNavigator.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final int indexPage = 2;
  Bottom getBottom = Bottom();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 150, 40, 0),
          child: ListView(
            children: [
              Center(
                  child: Text(
                'Êtes vous une femme ou un homme ?',
                style: TextStyle(fontSize: 18, color: Colors.red),
              )),
              SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quizFemme');
                },
                child: Text('Femme', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.white)))),
              ),
              SizedBox(height: 25),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/quizHomme');
                  },
                  child: Text(
                    'Homme',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.white))))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottom(
        indexPage: indexPage,
      ),
    );
  }
}
