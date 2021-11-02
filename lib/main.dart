import 'package:flutter/material.dart';
import 'package:news_app/screens/firstScreen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xffef7851),
      scaffoldBackgroundColor: Color(0xfff5f4f9),
    ),
      home: FirstScreen()));
}

