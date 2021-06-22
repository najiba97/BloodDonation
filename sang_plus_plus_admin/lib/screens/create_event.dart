import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sang_plus_plus_admin/services/database.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  AdminMedcinData adminMedcinData = AdminMedcinData();
  final formKey = GlobalKey<FormState>();

  String valueChoose = '';
  PickedFile imageFile;
  String heure = '',
      date = '',
      minute = '',
      lieux = '',
      imageUrl = '',
      erreurDate = '',
      erreurHeure = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.keyboard_return_outlined),
          color: Colors.blue[900],
        ),
        elevation: 0.5,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 150,
        title: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'Crée événement',
            style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            TableCalendar(
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  date = _focusedDay.toString().split(' ')[0];
                },
                focusedDay: _focusedDay,
                firstDay: DateTime.now(),
                lastDay: DateTime(2100)),
            Container(
              width: double.infinity,
              height: 500,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 20,
                          color: Colors.blue[900],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'date d\'événement :',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(_focusedDay.toString().split(' ')[0])
                      ],
                    ),
                    Text(
                      erreurDate,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_outlined,
                          size: 20,
                          color: Colors.blue[900],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'heure d\'événement :',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            onPressed: () async {
                              TimeOfDay chooseHour = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              setState(() {
                                if (chooseHour != null) {
                                  heure = chooseHour.hour.toString().length == 1
                                      ? '0${chooseHour.hour}'
                                      : '${chooseHour.hour}';
                                  minute =
                                      chooseHour.minute.toString().length == 1
                                          ? '0${chooseHour.minute}'
                                          : '${chooseHour.minute}';
                                }
                                print(minute);
                              });
                            },
                            child: heure == ''
                                ? Text(
                                    'choisir l\'heure',
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text(
                                    '$heure:$minute heure',
                                    style: TextStyle(color: Colors.black),
                                  )),
                      ],
                    ),
                    Text(
                      erreurHeure,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 20,
                          color: Colors.blue[900],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'lieux :',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        onChanged: (value) {
                          setState(() {
                            lieux = value;
                          });
                        },
                        validator: (value) => value.isEmpty
                            ? 'lieux ne peut pas etre vide'
                            : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelStyle: TextStyle(fontSize: 16),
                            hintText: ('ecrire le lieux de don'))),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 20,
                          color: Colors.blue[900],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'choisir une image :',
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageUrl == ''
                                      ? AssetImage('assets/images/picture.png')
                                      : FileImage(File(imageFile.path)))),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.blue[900],
                      onPressed: () async {
                        if (formKey.currentState.validate() &&
                            date != '' &&
                            heure != '') {
                          await adminMedcinData.createEvent(
                              lieux, '$date $heure:$minute', imageUrl);
                          Navigator.pop(context);

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'l\'événement a été créé avec succès'),
                                );
                              });
                        } else if (date == '') {
                          setState(() {
                            erreurDate = 'ce champ ne peut pas étre vide';
                          });
                        } else if (heure == '') {
                          setState(() {
                            erreurHeure = 'ce champ ne peut pas étre vide';
                          });
                        }
                      },
                      child: Icon(Icons.done),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
    setState(() {
      imageFile = pickedImage;
    });

    if (pickedImage != null) {
      var snapshot =
          await FirebaseStorage.instance.ref().child(file.path).putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('no path recived');
      return null;
    }
  }
}
