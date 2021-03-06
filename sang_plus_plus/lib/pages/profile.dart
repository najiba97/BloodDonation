import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';
import 'package:sang_plus_plus/pages/widgets/myappbar.dart';
import 'package:sang_plus_plus/services/bottom_navigator.dart';
import 'package:sang_plus_plus/services/database.dart';

import 'widgets/bottom.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Bottom getBottom = Bottom();
  PickedFile imageFile;
  final int indexPage = 3;
  String imgUrl;
  UserData userData = UserData();
  bool download = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var _uid = _auth.currentUser.uid;

    return download
        ? CircularLoad()
        : StreamProvider<DocumentSnapshot>.value(
            value: UserData().notification,
            initialData: null,
            child: Scaffold(
                backgroundColor: Colors.grey[100],
                appBar: MyAppBar(),
                body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return Text('Loading data .. please wait');
                    } else {
                      var document = snapshot.data;

                      return ListView(children: [
                        Column(children: [
                          Container(
                            height: 80,
                            color: Colors.teal[400],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(25)),
                                  color: Colors.teal[400],
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage:
                                      document['photo de profile'] == null
                                          ? AssetImage('assets/user.png')
                                          : NetworkImage(
                                              document['photo de profile']),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Positioned(
                                  right: 125,
                                  bottom: 15.0,
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: ((builder) =>
                                              bottomSheet()));
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.teal,
                                      size: 28.0,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    UserData(uid: _uid)
                                        .updateInfo('nom', value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: document['nom'],
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    UserData(uid: _uid)
                                        .updateInfo('pr??nom', value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: document['pr??nom'],
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ]);
                    }
                  },
                ),
                bottomNavigationBar: MyBottom(
                  indexPage: indexPage,
                )),
          );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            'changer votre photo',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () async => await takePhoto(ImageSource.gallery),
                  icon: Icon(Icons.image),
                  label: Text('Galerie'))
            ],
          )
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    var file = File(pickedImage.path);

    if (pickedImage != null) {
      setState(() {
        download = true;
      });
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child(_auth.currentUser.uid)
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imgUrl = downloadUrl;
      });

      setState(() {
        download = false;
      });
    } else {
      print('no path recived');
    }

    await UserData(uid: _auth.currentUser.uid).userPic(imgUrl);
  }
}
