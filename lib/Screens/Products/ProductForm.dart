import 'dart:io';
import 'dart:typed_data';

import 'package:admin_thrifters/FirebaseAPI/CategoryAPI.dart';
import 'package:admin_thrifters/FirebaseAPI/ProductAPI.dart';
import 'package:admin_thrifters/customUI/CategoryFilter.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:admin_thrifters/models/Category.dart' as CATEGORY;
import 'package:admin_thrifters/models/Product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProductForm extends StatefulWidget {
  final Product currentProduct;
  ProductForm({Key key, this.currentProduct}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  int selectedPage = 0;
  String dropDownValue;
  bool checkboxListTileValue2;
  bool checkboxListTileValue3;
  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController priceController;
  TextEditingController comparePriceController;
  TextEditingController costController;
  bool checkboxListTileValue1;
  TextEditingController vendorController;
  TextEditingController productTypeController;
  TextEditingController skyController;
  TextEditingController barcodeController;
  bool checkboxListTileValue4;
  bool checkboxListTileValue5;
  List<String> imagesURL = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  void initState() {
    super.initState();
    widget.currentProduct?.images?.forEach((imageURL) {
      imagesURL.add(imageURL);
    });
    titleController = TextEditingController(text: widget.currentProduct?.title);
    descriptionController =
        TextEditingController(text: widget.currentProduct?.description);
    priceController =
        TextEditingController(text: widget.currentProduct?.price.toString());
    comparePriceController = TextEditingController();
    costController = TextEditingController();
    vendorController =
        TextEditingController(text: widget.currentProduct?.brand);
    skyController = TextEditingController();
    barcodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: TextFormField(
                        controller: titleController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          hintText: 'Title',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Required';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: TextFormField(
                        controller: descriptionController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          hintText: 'Description',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        keyboardType: TextInputType.multiline,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Required';
                          }

                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Consumer<CategoryProvider>(builder: (context, model, child) {
              return Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            model.selectedCategories?.length == 0
                                ? SizedBox()
                                : TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryFilter()),
                                      );
                                    },
                                    child: Text('Add category')),
                          ],
                        ),
                      ),
                      Container(
                        height: 175,
                        child: model.selectedCategories?.length == 0
                            ? Center(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryFilter()),
                                      );
                                    },
                                    child: Text('Add category')),
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: SingleChildScrollView(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        model.selectedCategories?.length,
                                        (index) {
                                      CATEGORY.Category category =
                                          model.selectedCategories[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(15, 15, 15, 15),
                                              child: Text(
                                                category.name,
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              );
            }),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Images',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          imagesURL.length == 0
                              ? SizedBox()
                              : TextButton(
                                  onPressed: loadImages,
                                  child: Text('Add image')),
                        ],
                      ),
                    ),
                    Container(
                      height: 175,
                      child: imagesURL.length == 0
                          ? Center(
                              child: TextButton(
                                  onPressed: loadImages,
                                  child: Text('Add image')),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: SingleChildScrollView(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      List.generate(imagesURL.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  imagesURL[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.close_sharp,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  imagesURL
                                                      .remove(imagesURL[index]);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                              // child: Column(
                              //   children: [
                              //     Expanded(
                              //       child: PageView(
                              //         controller: _pageController,
                              //         onPageChanged: (page) {
                              //           setState(() {
                              //             selectedPage = page;
                              //           });
                              //         },
                              //         children: List.generate(
                              //             imagesURL.length, (index) {
                              //           return Padding(
                              //             padding:
                              //                 const EdgeInsets.all(15.0),
                              //             child: Container(
                              //               decoration: BoxDecoration(
                              //                 color: Color(0xFFEEEEEE),
                              //                 image: DecorationImage(
                              //                   fit: BoxFit.cover,
                              //                   image: NetworkImage(
                              //                     imagesURL[index],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 24),
                              //       child: PageViewDotIndicator(
                              //         currentItem: selectedPage,
                              //         count: imagesURL.length,
                              //         unselectedColor: Colors.black26,
                              //         selectedColor: Colors.blue,
                              //         duration: Duration(milliseconds: 200),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Pricing',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                            child: TextFormField(
                              controller: priceController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Price',
                                labelStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                hintText: 'Price',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Required';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                            child: TextFormField(
                              controller: comparePriceController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Compare at price',
                                labelStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                hintText: 'Compare at price',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Require';
                                }

                                return null;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                      color: Color(0xFFE2E2E2),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                            child: TextFormField(
                              controller: costController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Cost per item',
                                labelStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                hintText: 'Cost per item',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 30, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Margin',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 15, 15, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Profit',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(),
                        )
                      ],
                    ),
                    CheckboxListTile(
                      value: checkboxListTileValue1 ??= true,
                      onChanged: (newValue) =>
                          setState(() => checkboxListTileValue1 = newValue),
                      title: Text(
                        'Title',
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Product Status',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                          child: FlutterFlowDropDown(
                            options: ['Draft', 'Active'].toList(),
                            onChanged: (val) =>
                                setState(() => dropDownValue = val),
                            width: 130,
                            height: 40,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            elevation: 2,
                            borderColor: Colors.transparent,
                            borderWidth: 0,
                            borderRadius: 0,
                            margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Sales channels and Apps',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                      color: Color(0xFFE2E2E2),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Sales channels and Apps',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                      color: Color(0xFFE2E2E2),
                    ),
                    CheckboxListTile(
                      value: checkboxListTileValue2 ??= true,
                      onChanged: (newValue) =>
                          setState(() => checkboxListTileValue2 = newValue),
                      title: Text(
                        'Online Store',
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 15, 15, 15),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                      color: Color(0xFFE2E2E2),
                    ),
                    CheckboxListTile(
                      value: checkboxListTileValue3 ??= true,
                      onChanged: (newValue) =>
                          setState(() => checkboxListTileValue3 = newValue),
                      title: Text(
                        'Point Of Sales',
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Organization',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: TextFormField(
                        controller: vendorController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Vendor',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          hintText: 'Vendor',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Required';
                          }

                          return null;
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                      color: Color(0xFFE2E2E2),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: TextFormField(
                        controller: productTypeController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Product Type',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          hintText: 'Product Type',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Required';
                          }

                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Text(
                        'Inventory',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                            child: TextFormField(
                              controller: skyController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'SKU (Stock Keeping Unit)',
                                labelStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                hintText: 'SKU (Stock Keeping Unit)',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Required';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                            child: TextFormField(
                              controller: barcodeController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Barcode (ISBN, UPC, GTIN, etc.)',
                                labelStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                hintText: 'Barcode (ISBN, UPC, GTIN, etc.)',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Required';
                                }

                                return null;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    CheckboxListTile(
                      value: checkboxListTileValue4 ??= true,
                      onChanged: (newValue) =>
                          setState(() => checkboxListTileValue4 = newValue),
                      title: Text(
                        'Track quantity',
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      value: checkboxListTileValue5 ??= false,
                      onChanged: (newValue) =>
                          setState(() => checkboxListTileValue5 = newValue),
                      title: Text(
                        'Continue selling when out of stock',
                        style: FlutterFlowTheme.title3.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.75, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                child: RoundedLoadingButton(
                  child: Text(widget.currentProduct == null ? 'Add' : 'Save',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      _btnController.start();
                      try {
                        Product product = Product(
                          productId: widget.currentProduct == null
                              ? null
                              : widget.currentProduct.productId,
                          title: titleController.text,
                          images: imagesURL,
                          description: descriptionController.text,
                          categories:
                              CategoryProvider.of(context, listen: false)
                                  .selectedCategories,
                          brand: vendorController.text,
                          publishedAt: DateTime.now(),
                          isVisible: true,
                          price: num.tryParse(priceController.value.text)
                              ?.toDouble(),
                        );
                        if (widget.currentProduct == null) {
                          await ProductAPI.addProduct(product: product)
                              .whenComplete(() {
                            setState(() {
                              _btnController.success();
                              Fluttertoast.showToast(
                                  msg: 'Product added successfully');
                            });
                          });
                        } else {
                          await ProductAPI.setProducts(product: product)
                              .whenComplete(() {
                            setState(() {
                              _btnController.success();
                              Fluttertoast.showToast(
                                  msg: 'Product saved successfully');
                            });
                          });
                        }
                      } catch (e) {
                        setState(() {
                          _btnController.error();
                          Fluttertoast.showToast(
                            msg: 'Failed to add Product, try again later',
                          );
                        });
                      }
                    } else {
                      _btnController.reset();
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFE2E2E2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future loadImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      String fileName = result.files.first.name;
      final destination = 'products/$fileName';
      UploadTask uploadTask;
      if (kIsWeb) {
        Uint8List bytes = result.files.first.bytes;
        uploadTask = ProductAPI.uploadBytes(destination, bytes);
      } else {
        File file = File(result.files.first.path);
        uploadTask = ProductAPI.uploadFile(destination, file);
      }
      if (uploadTask != null) {
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        setState(() {
          // Future.delayed(Duration(seconds: 3));
          imagesURL.add(urlDownload);
        });
      }
    }
  }
}
