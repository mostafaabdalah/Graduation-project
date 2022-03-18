import 'package:flutter/material.dart';
import 'package:hommey/Home/Home.dart';
import 'package:hommey/Login/Login.dart';
import 'package:hommey/Models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (new User().getUserName() == null || new User().getUserName().length<0 ) {
      return MaterialApp(home: new Login());
    } else {
      return MaterialApp(home: new Home());
    }
  }
}
