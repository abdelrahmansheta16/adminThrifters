import 'package:admin_thrifters/FirebaseAPI/OrderAPI.dart';
import 'package:admin_thrifters/FirebaseAPI/UserAPI.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:admin_thrifters/customUI/MyProfile.dart';
import 'package:admin_thrifters/customUI/OrdersTable.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:admin_thrifters/models/Order.dart';
import 'package:admin_thrifters/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
  static final id = '/Orders';
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(
        child: StreamBuilder<QuerySnapshot<Order>>(
          stream: OrderAPI.loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Text('fdfsd');
            }
            List<Order> orders =
                snapshot.data.docs.map((DocumentSnapshot document) {
              Order order;
              order = document.data();
              order.orderID = document.id;
              return order;
            }).toList();
            return OrdersTable(
              orders: orders,
            );
          },
        ),
        title: 'Orders');
  }
}
