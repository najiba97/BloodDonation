import 'package:flutter/material.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

class GMedecin extends StatelessWidget {
  List myMedecins = [];
  GMedecin({this.myMedecins});
  AdminMedcinData adminMedcinData = AdminMedcinData();

  @override
  Widget build(BuildContext context) {
    return myMedecins.length > 0
        ? Scaffold(
            backgroundColor: Colors.grey[100],
            body: ListView.builder(
                itemCount: myMedecins.length,
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
                                      'changer l\'identification de ${myMedecins[index]['nom']} ${myMedecins[index]['prénom']}?'),
                                  content: Row(
                                    children: [
                                      TextButton(
                                        child: Text('administrateur'),
                                        onPressed: () async {
                                          await adminMedcinData.changeIdentif(
                                              myMedecins[index]['uid'],
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
                                        child: Text('utilisateur'),
                                        onPressed: () async {
                                          await adminMedcinData.changeIdentif(
                                              myMedecins[index]['uid'],
                                              'utilisateur');

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
                          backgroundImage:
                              myMedecins[index]['photo de profile'] == null
                                  ? AssetImage('assets/images/user.png')
                                  : NetworkImage(
                                      myMedecins[index]['photo de profile']),
                        ),
                        title: Text(
                          ' ${myMedecins[index]['nom']} ${myMedecins[index]['prénom']}',
                        ),
                        subtitle: Text(
                          myMedecins[index]['identif'],
                        ),
                      ),
                    ),
                  );
                }),
          )
        : Scaffold(
            body: Center(
              child: Text('aucun médecin'),
            ),
          );
  }
}
