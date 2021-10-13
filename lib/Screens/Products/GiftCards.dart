import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class GiftCards extends StatefulWidget {
  const GiftCards({Key key}) : super(key: key);

  @override
  _GiftCardsState createState() => _GiftCardsState();
  static final id = '/Products/GiftCards';
}

class _GiftCardsState extends State<GiftCards> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Gift Cards');
  }
}
