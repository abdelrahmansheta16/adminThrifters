import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  const Customers({Key key}) : super(key: key);

  @override
  _CustomersState createState() => _CustomersState();
  static final id = '/Customers';
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Costumers');
  }
}
