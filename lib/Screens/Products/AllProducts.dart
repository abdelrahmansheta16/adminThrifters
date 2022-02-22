import 'package:admin_thrifters/FirebaseAPI/ProductAPI.dart';
import 'package:admin_thrifters/FirebaseAPI/ProductProvider.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:admin_thrifters/customUI/ProductsTable.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
  static final id = '/Products/AllProducts';
}

class _AllProductsState extends State<AllProducts> {
  String dropDownValue1;
  TextEditingController textController;
  String dropDownValue2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CurrentScreen(
        child: StreamBuilder<QuerySnapshot<Product>>(
            stream: ProductAPI.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<Product> products =
                  snapshot.data.docs.map((DocumentSnapshot document) {
                Product product;
                product = document.data();
                product.productId = document.id;
                ProductAPI.ProductsRef.doc(document.id).set(product);
                return product;
              }).toList();
              // Wait for the widget to build before calling this function
              // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              //   ProductProvider.of(context, listen: false).setProducts(products);
              // });
              return ProductsTable(
                products: products,
              );
            }),
        title: 'All Products');
  }
}
