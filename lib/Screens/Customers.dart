import 'package:admin_thrifters/FirebaseAPI/UserAPI.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:admin_thrifters/customUI/UsersTable.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return CurrentScreen(
        child: StreamBuilder<QuerySnapshot<USER>>(
            stream: UserAPI.loadUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<USER> users =
                  snapshot.data.docs.map((DocumentSnapshot document) {
                USER user;
                user = document.data();
                user.userID = document.id;
                return user;
              }).toList();
              return UsersTable(
                users: users,
              );
            }),
        title: 'Costumers');
  }
}
