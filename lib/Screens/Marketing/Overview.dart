import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({Key key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
  static final id = '/Marketing/Overview';
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Overview');
    ;
  }
}
