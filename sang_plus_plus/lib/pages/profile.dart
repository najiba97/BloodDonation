import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
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

  final ImagePicker picker = ImagePicker();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var _uid = _auth.currentUser.uid;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Profil',
          ),
          backgroundColor: Colors.red[100],
          actions: [
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.notifications_active,
                  size: 40,
                  color: Colors.black,
                ),
                onPressed: () {},
                splashColor: Colors.green,
              ),
            )
          ],
        ),
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.red[100], Colors.red[300]])),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(100, 150, 100, 0),
                      child: Column(children: [
                        Center(
                            child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 75.0,
                              backgroundImage:
                                  document['photo de profile'] == null
                                      ? AssetImage('assets/user.png')
                                      : FileImage(
                                          File(document['photo de profile'])),
                              backgroundColor: Colors.white,
                            ),
                            Positioned(
                                right: -2.0,
                                bottom: 15.0,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) => bottomSheet()));
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.teal,
                                    size: 28.0,
                                  ),
                                ))
                          ],
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          onChanged: (value) {
                            UserData(uid: _uid).updateInfo('nom', value);
                          },
                          decoration: InputDecoration(
                            hintText: document['nom'],
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            UserData(uid: _uid).updateInfo('prénom', value);
                          },
                          decoration: InputDecoration(
                            hintText: document['prénom'],
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ])),
                ),
              ]);
            }
          },
        ),
        bottomNavigationBar: MyBottom(
          indexPage: indexPage,
        ));
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
                    final File file = File(imageFile.path);

                    Reference storage =
                        FirebaseStorage.instance.ref().child('myImage.jpg');
                    final UploadTask task = storage.putFile(file);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () async {
                    takePhoto(ImageSource.gallery);
                    final File file = File(imageFile.path);

                    Reference storage =
                        await FirebaseStorage.instance.ref().child('krich');
                     UploadTask task = storage.putFile(file);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Galerie'))
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      imageFile = pickedImage;
    });
    await UserData(uid: _auth.currentUser.uid).userPic(imageFile.path);
  }
}
