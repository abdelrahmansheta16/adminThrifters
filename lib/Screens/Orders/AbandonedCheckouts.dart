import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class AbandonedCheckouts extends StatefulWidget {
  const AbandonedCheckouts({Key key}) : super(key: key);

  @override
  _AbandonedCheckoutsState createState() => _AbandonedCheckoutsState();
  static final id = '/Orders/AbandonedCheckouts';
}

class _AbandonedCheckoutsState extends State<AbandonedCheckouts> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Abandoned Checkouts');
  }
}
