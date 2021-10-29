import 'package:admin_thrifters/Screens/Products/ProductForm.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
  static final id = '/Products/AddProducts';
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(
      child: ProductForm(),
      title: 'Add Product',
    );
  }
}
