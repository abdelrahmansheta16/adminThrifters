import 'package:admin_thrifters/FirebaseAPI/ProductAPI.dart';
import 'package:admin_thrifters/Screens/Home.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:admin_thrifters/models/Product.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

  static final id = '/';
}

class _MainScreenState extends State<MainScreen> {
  // @override
  // void initState() {
  //   Product product = Product(
  //       title: 'title',
  //       images: [
  //         'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80',
  //         'https://images.unsplash.com/photo-1518568740560-333139a27e72?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhY2glMjBsb3ZlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
  //         'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'
  //       ],
  //       description: 'description',
  //       type: 'type',
  //       brand: 'brand',
  //       size: ['1', '2', '3'],
  //       category: 'category',
  //       color: ['1', '2', '3'],
  //       isSoldOut: true,
  //       isBackorder: true,
  //       isVisible: true,
  //       price: 651,
  //       inventoryManagement: true,
  //       inventoryPolicy: true,
  //       taxable: true);
  //   ProductAPI.addProducts(product: product);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return CurrentScreen(
      title: 'HOME',
      child: Home(),
    );
  }
}
