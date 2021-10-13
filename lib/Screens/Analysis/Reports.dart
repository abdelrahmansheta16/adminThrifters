import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
  static final id = '/Analysis/Reports';
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Reports');;
  }
}
