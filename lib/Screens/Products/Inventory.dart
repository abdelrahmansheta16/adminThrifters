import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key key}) : super(key: key);

  @override
  _InventoryState createState() => _InventoryState();
  static final id = '/Products/Inventory';
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Inventory');
  }
}
