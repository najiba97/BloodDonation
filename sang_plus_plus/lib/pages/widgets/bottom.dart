import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sang_plus_plus/pages/widgets/connected_nav.dart';
import 'package:sang_plus_plus/services/bottom_navigator.dart';

class MyBottom extends StatelessWidget {
  final int indexPage;
  MyBottom({this.indexPage});

  @override
  Widget build(BuildContext context) {
    Bottom getBottom = Bottom();
    final user = Provider.of<User>(context);
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: true,
        items: user != null ? connectedNavBar : unconnectedNavBar,
        onTap: (index) {
          if (index == indexPage) {
          } else {
            getBottom.choosePage(index, context);
          }
        });
  }
}
