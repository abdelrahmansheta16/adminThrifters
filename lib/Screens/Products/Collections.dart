import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Collection extends StatefulWidget {
  const Collection({Key key}) : super(key: key);

  @override
  _CollectionState createState() => _CollectionState();
  static final id = '/Products/Collections';
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Collections');
  }
}
