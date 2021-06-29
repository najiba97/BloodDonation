import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus/services/database.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    final notif = Provider.of<DocumentSnapshot>(context);

    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text('Profile'),
      backgroundColor: Colors.teal[400],
      actions: [
        Stack(
          children: [
            notif.data()['date&heure'] != null && notif.data()['read'] == false
                ? Positioned(
                    bottom: 10,
                    child: Text(
                      '1',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ))
                : Text(''),
            IconButton(
              icon: Icon(
                Icons.notifications_active,
                size: 40,
                color: notif.data()['date&heure'] != null &&
                        notif.data()['read'] == false
                    ? Colors.red
                    : Colors.teal[50],
              ),
              onPressed: () async {
                if (notif.data()['date&heure'] != null) {
                  await userData.updateNotif();
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('votre rendez-vous est confirmé le :'),
                          content: Text(
                            '${notif.data()['date&heure']}',
                            style: TextStyle(
                                color: Colors.grey[600], letterSpacing: 1),
                          ),
                        );
                      });
                } else {}
              },
              splashColor: Colors.green,
            ),
          ],
        )
      ],
    );
  }
}
