import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink[100]),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/heartbeat.png',
                    width: 250,
                    height: 67,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'sang++',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                leading: Icon(Icons.announcement_outlined),
                title: Text(
                  'A propos',
                  style: TextStyle(fontSize: 16.0, fontFamily: 'PlayFair'),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/propos');
                },
              ),
              ListTile(
                leading: Icon(Icons.call),
                title: Text('Contacter nous',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'PlayFair')),
                onTap: () {
                  Navigator.pushNamed(context, '/contacte');
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time_outlined),
                title: Text('Prendre rendez-vous',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PlayfairDisplay-Regular.ttf')),
                onTap: () {
                  Navigator.pushNamed(context, '/rendez');
                },
              ),
              ListTile(
                leading: Icon(Icons.add_alarm),
                title: Text('Consigne après don',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PlayfairDisplay-Regular.ttf')),
                onTap: () {
                  Navigator.pushNamed(context, '/consigne');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
