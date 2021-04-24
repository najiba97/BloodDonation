import 'package:flutter/material.dart';

class Bottom {
  List<String> pages = ['/menu', '/location', '/quiz', '/profile'];

  void choosePage(n, context) {
    Navigator.pushNamed(context, pages[n]);
  }
}
