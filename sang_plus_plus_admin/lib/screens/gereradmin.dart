import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

class GAdmin extends StatelessWidget {
  List myAdmins = [];
  GAdmin({this.myAdmins});
  AdminMedcinData adminMedcinData = AdminMedcinData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
          itemCount: myAdmins.length,
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
                                'changer l\'identification de ${myAdmins[index]['nom']} ${myAdmins[index]['prénom']}?'),
                            content: Row(
                              children: [
                                TextButton(
                                  child: Text('utilisateur'),
                                  onPressed: () async {
                                    await adminMedcinData.changeIdentif(
                                        myAdmins[index]['uid'], 'utilisateur');

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
                                        myAdmins[index]['uid'], 'médecin');

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
                    backgroundImage: myAdmins[index]['photo de profile'] == null
                        ? AssetImage('assets/images/user.png')
                        : NetworkImage(myAdmins[index]['photo de profile']),
                  ),
                  title: Text(
                      ' ${myAdmins[index]['nom']} ${myAdmins[index]['prénom']}'),
                  subtitle: Text(myAdmins[index]['identif']),
                ),
              ),
            );
          }),
    );
  }
}
