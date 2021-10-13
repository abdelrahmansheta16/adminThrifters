import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Dashboards extends StatefulWidget {
  const Dashboards({Key key}) : super(key: key);

  @override
  _DashboardsState createState() => _DashboardsState();
  static final id = '/Analysis/Dashboards';
}

class _DashboardsState extends State<Dashboards> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Dashboards');
  }
}
