import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Drafts extends StatefulWidget {
  const Drafts({Key key}) : super(key: key);

  @override
  _DraftsState createState() => _DraftsState();
  static final id = '/Orders/Drafts';
}

class _DraftsState extends State<Drafts> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Drafts');
  }
}
