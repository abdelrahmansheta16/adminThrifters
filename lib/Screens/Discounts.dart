import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Discounts extends StatefulWidget {
  const Discounts({Key key}) : super(key: key);

  @override
  _DiscountsState createState() => _DiscountsState();
  static final id = '/Discounts';
}

class _DiscountsState extends State<Discounts> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Discounts');
  }
}
