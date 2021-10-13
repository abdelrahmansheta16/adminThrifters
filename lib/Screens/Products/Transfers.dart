import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Transfers extends StatefulWidget {
  const Transfers({Key key}) : super(key: key);

  @override
  _TransfersState createState() => _TransfersState();
  static final id = '/Products/Transfers';
}

class _TransfersState extends State<Transfers> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Transfers');
  }
}
