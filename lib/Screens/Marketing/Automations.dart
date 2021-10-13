import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Automations extends StatefulWidget {
  const Automations({Key key}) : super(key: key);

  @override
  _AutomationsState createState() => _AutomationsState();
  static final id = '/Marketing/Automations';
}

class _AutomationsState extends State<Automations> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Automations');
    ;
  }
}
