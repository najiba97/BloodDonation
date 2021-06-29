import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

class GUser extends StatefulWidget {
  List myUsers = [];

  GUser({this.myUsers});

  @override
  _GUserState createState() => _GUserState();
}

class _GUserState extends State<GUser> {
  AdminMedcinData adminMedcinData = AdminMedcinData();

  @override
  Widget build(BuildContext context) {
    return widget.myUsers.length > 0
        ? Scaffold(
            backgroundColor: Colors.grey[100],
            body: ListView.builder(
                itemCount: widget.myUsers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                      child: ListTile(
                        onTap: () {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'changer l\'identification de ${widget.myUsers[index]['nom']} ${widget.myUsers[index]['prénom']}?'),
                                  content: Row(
                                    children: [
                                      TextButton(
                                        child: Text('administrateur'),
                                        onPressed: () async {
                                          await adminMedcinData.changeIdentif(
                                              widget.myUsers[index]['uid'],
                                              'administrateur');

                                          Navigator.pushNamed(
                                              context, '/gerer_utilisateur');
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'modification effectuée avec succès'),
                                                );
                                              });
                                        },
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      TextButton(
                                        child: Text('médecin'),
                                        onPressed: () async {
                                          await adminMedcinData.changeIdentif(
                                              widget.myUsers[index]['uid'],
                                              'médecin');

                                          Navigator.pushNamed(
                                              context, '/gerer_utilisateur');
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'modification effectuée avec succès'),
                                                );
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          backgroundImage: widget.myUsers[index]
                                      ['photo de profile'] ==
                                  null
                              ? AssetImage('assets/images/user.png')
                              : NetworkImage(
                                  widget.myUsers[index]['photo de profile']),
                        ),
                        title: Text(
                            ' ${widget.myUsers[index]['nom']} ${widget.myUsers[index]['prénom']}'),
                        subtitle: Text(widget.myUsers[index]['identif']),
                      ),
                    ),
                  );
                }))
        : Scaffold(
            body: Center(child: Text('aucun utilisateur')),
          );
  }
}
