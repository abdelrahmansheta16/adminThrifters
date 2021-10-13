import 'package:admin_thrifters/Screens/Home.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

  static final id = '/';
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(
      title: 'HOME',
      child: Home(),
    );
  }
}
