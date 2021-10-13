import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class LiveView extends StatefulWidget {
  const LiveView({Key key}) : super(key: key);

  @override
  _LiveViewState createState() => _LiveViewState();
  static final id = '/Analysis/LiveView';
}

class _LiveViewState extends State<LiveView> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'LiveView');
  }
}
