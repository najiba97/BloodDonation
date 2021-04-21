import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus/pages/services/auth_service.dart';
import 'package:sang_plus_plus/pages/widgets/bottom.dart';
import 'package:sang_plus_plus/pages/widgets/cirular_load.dart';

import 'package:sang_plus_plus/pages/widgets/drawer.dart';
import 'package:video_player/video_player.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final AuthServices _auth = AuthServices();
  FirebaseAuth authfire = FirebaseAuth.instance;

  final int indexPage = 0;
  bool disconnect = false;

  List<String> videos = ['videos/motivateDonor.mp4'];
  List<VideoPlayerController> videoControllers = [];

  List<ChewieController> _chewieController = [];

  @override
  void initState() {
    super.initState();
    videoControllers = [
      VideoPlayerController.asset(videos[0],
          videoPlayerOptions: VideoPlayerOptions()),
    ];

    _chewieController = [
      ChewieController(
        videoPlayerController: videoControllers[0],
        aspectRatio: 3 / 2,
        autoPlay: false,
        looping: false,
        placeholder: Image(
          image: AssetImage('assets/motiveSang_Moment.jpg'),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    videoControllers[0].dispose();
    _chewieController[0].dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return disconnect
        ? CircularLoad()
        : Scaffold(
            backgroundColor: Colors.red[100],
            drawer: MyDrawer(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150),
              child: AppBar(
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.grey),
                  flexibleSpace: Image(
                    image: AssetImage('assets/sangplus.jpg'),
                    fit: BoxFit.cover,
                  ),
                  backgroundColor: Colors.redAccent[200],
                  actions: [
                    TextButton.icon(
                        onPressed: user != null
                            ? () {
                                setState(() {
                                  disconnect = true;
                                });
                                _auth.signOut();
                              }
                            : () {
                                Navigator.pushNamed(context, '/authentif');
                              },
                        icon: user != null
                            ? Icon(Icons.logout)
                            : Icon(Icons.login),
                        label: user != null
                            ? Text('déconnexion')
                            : Text('connexion'))
                  ]),
            ),
            body: Center(
              child: ListView(
                children: [
                  Container(
                    height: 250,
                    width: 200,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(1, (index) {
                          return Column(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Chewie(
                                  controller: _chewieController[index],
                                ),
                              )),
                            ],
                          );
                        })),
                  )
                ],
              ),
            ),
            bottomNavigationBar: MyBottom(
              indexPage: indexPage,
            ),
          );
  }
}
