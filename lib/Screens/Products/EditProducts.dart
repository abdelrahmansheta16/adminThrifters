import 'package:admin_thrifters/Screens/MainScreen.dart';
import 'package:admin_thrifters/Screens/Products/AllProducts.dart';
import 'package:admin_thrifters/customUI/ProductForm.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProducts extends StatefulWidget {
  EditProducts({Key key}) : super(key: key);

  @override
  _EditProductsState createState() => _EditProductsState();
  static final id = '/Products/EditProducts';
}

class _EditProductsState extends State<EditProducts> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.id, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
        title: Text(
          'Edit Products',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(products.length, (index) {
              return ProductForm(
                currentProduct: products[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}
