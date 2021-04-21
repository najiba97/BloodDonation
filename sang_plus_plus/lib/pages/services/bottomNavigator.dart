import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottom {
  List<String> pages = ['/menu', '/location', '/quiz', '/profile'];

  void choosePage(n, context) {
    Navigator.pushNamed(context, pages[n]);
  }
}
