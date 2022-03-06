import 'dart:io';
import 'dart:typed_data';

import 'package:admin_thrifters/FirebaseAPI/ProductProvider.dart';
import 'package:admin_thrifters/FirebaseAPI/ProductAPI.dart';
import 'package:admin_thrifters/customUI/BrandPage.dart';
import 'package:admin_thrifters/customUI/CategoryContainer.dart';
import 'package:admin_thrifters/customUI/CategoryFilter.dart';
import 'package:admin_thrifters/customUI/SizesPage.dart';
import 'package:admin_thrifters/customUI/pdfPage.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:thrifters_classes/thrifters_classes.dart' as th;
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class ProductForm extends StatefulWidget {
  final th.Product currentProduct;
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
  List<String> categories = [];
  TextEditingController textController1;
  TextEditingController textController2;
  final alertKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  GlobalKey alertDialogKey = new GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _deleteController =
      RoundedLoadingButtonController();

  final _multiKey = GlobalKey<DropdownSearchState<String>>();

  bool isFormEnabled = false;
  th.Brand choosenBrand;
  bool isEditingMode = false;
  double profit = 0;



  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();

    widget.currentProduct?.images?.forEach((imageURL) {
      imagesURL.add(imageURL);
    });
    widget.currentProduct?.categories?.forEach((category) {
      categories.add(category);
    });
    titleController = TextEditingController(text: widget.currentProduct?.title);
    descriptionController =
        TextEditingController(text: widget.currentProduct?.description);
    priceController = TextEditingController(
        text: widget.currentProduct == null
            ? ''
            : widget.currentProduct.beforePrice.toString());
    comparePriceController = TextEditingController();
    costController = TextEditingController();
    vendorController =
        TextEditingController(text: widget.currentProduct?.brand?.name);
    skyController = TextEditingController();
    barcodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          widget.currentProduct == null ? 'Add Product' : 'Edit Product',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                          maxLines: null,
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
              Consumer<ProductProvider>(builder: (context, model, child) {
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
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
                              categories.length == 0
                                  ? SizedBox()
                                  : TextButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryFilter()),
                                        );
                                        setState(() {
                                          categories.clear();
                                          ProductProvider.of(context,
                                                  listen: false)
                                              .selectedCategories
                                              .forEach((element) {
                                            categories.add(element);
                                          });
                                        });
                                      },
                                      child: Text('Add category')),
                            ],
                          ),
                        ),
                        Container(
                          height: 175,
                          child: categories.length == 0
                              ? Center(
                                  child: TextButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryFilter()),
                                        );
                                        setState(() {
                                          categories.clear();
                                          ProductProvider.of(context,
                                                  listen: false)
                                              .selectedCategories
                                              .forEach((element) {
                                            categories.add(element);
                                          });
                                        });
                                      },
                                      child: Text('Add category')),
                                )
                              : CategoryContainer(
                                  categories: categories,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(imagesURL.length,
                                        (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              imagesURL[index],
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.fill,
                                              errorBuilder: (BuildContext context,
                                                  Object exception,
                                                  StackTrace stackTrace) {
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                );
                                              },
                                              loadingBuilder: (BuildContext context,
                                                  Widget child,
                                                  ImageChunkEvent loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress
                                                        .expectedTotalBytes !=
                                                        null
                                                        ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                        : null,
                                                    color: Colors.black12,
                                                  ),
                                                );
                                              },
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
                                                    imagesURL.remove(
                                                        imagesURL[index]);
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: TextFormField(
                                onChanged: (string){
                                  setState(() {
                                    try {
                                      profit = double.tryParse(priceController.text)-double.tryParse(costController.text);
                                    } catch (error) {
                                      print(error);
                                      profit = 0; // your default value
                                    }
                                  });
                                },
                                controller: priceController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  labelStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  hintText: 'Price',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText1.override(
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: TextFormField(
                                controller: comparePriceController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Compare at price',
                                  labelStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  hintText: 'Compare at price',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText1.override(
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: TextFormField(
                                onChanged: (string){
                                  setState(() {
                                    try {
                                      profit = double.tryParse(priceController.text)-double.tryParse(costController.text);
                                    } catch (error) {
                                      print(error);
                                    profit = 0; // your default value
                                    }
                                  });
                                },
                                controller: costController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Cost per item',
                                  labelStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  hintText: 'Cost per item',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText1.override(
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
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(15, 15, 30, 15),
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.max,
                          //     children: [
                          //       Text(
                          //         'Margin',
                          //         style: FlutterFlowTheme.bodyText1.override(
                          //           fontFamily: 'Poppins',
                          //         ),
                          //       ),
                          //       Container(
                          //         decoration: BoxDecoration(),
                          //       )
                          //     ],
                          //   ),
                          // ),
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
                                Text(profit.toString()),
                                // Text((int.parse(priceController.text)??0-int.parse(costController.text)??0).toString()??'0'),
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
                              options: ['Draft', 'Active','Sold'].toList(),
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
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
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
                      Consumer<ProductProvider>(
                          builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<th.Brand>(
                                  items: model.initialBrands,
                                  maxHeight: 300,
                                  onFind: (String filter) => getData(filter),
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "choose a brand",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 0, 0),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (Brand brand) {
                                    setState(() {
                                      choosenBrand = brand;
                                    });
                                  },
                                  showSearchBox: true,
                                  dropdownBuilder: _customDropDownExample,
                                  popupItemBuilder:
                                      _customPopupItemBuilderExample2,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext alertContext) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                              key: alertDialogKey,
                                              scrollable: true,
                                              title: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Add Brand'),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.clear,
                                                        color: Colors.black,
                                                        size: 30,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            alertContext);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              content: AlertContainer(
                                                  setState, alertContext),
                                            );
                                          });
                                        });
                                  },
                                  child: Text('add brand'))
                            ],
                          ),
                        );
                      }),
                      Consumer<ProductProvider>(
                          builder: (context, model, child) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SizesPage()),
                            );
                          },
                          title: Text('Sizes'),
                          subtitle:
                              Text(model.size == null ? '' : model.size.name),
                          trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        );
                      }),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: TextFormField(
                                controller: skyController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'SKU (Stock Keeping Unit)',
                                  labelStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  hintText: 'SKU (Stock Keeping Unit)',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText1.override(
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: TextFormField(
                                controller: barcodeController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Barcode (ISBN, UPC, GTIN, etc.)',
                                  labelStyle:
                                      FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  hintText: 'Barcode (ISBN, UPC, GTIN, etc.)',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText1.override(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: RoundedLoadingButton(
                        child: Text(
                            widget.currentProduct == null ? 'Add' : 'Save',
                            style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            _btnController.start();
                            try {
                              th.Product product = th.Product(
                                productId: widget.currentProduct == null
                                    ? null
                                    : widget.currentProduct.productId,
                                title: titleController.text,
                                images: imagesURL,
                                description: descriptionController.text,
                                categories:
                                    ProductProvider.of(context, listen: false)
                                        .selectedCategories,
                                brand: choosenBrand,
                                status: dropDownValue,
                                publishedAt: DateTime.now(),
                                isVisible: true,
                                size: ProductProvider.of(context, listen: false)
                                    .size,
                                afterPrice:
                                    num.tryParse(priceController.value.text)
                                        ?.toDouble(),
                                beforePrice: num.tryParse(
                                        comparePriceController.value.text)
                                    ?.toDouble(),
                              );
                              if (widget.currentProduct == null) {
                                th.Product newProduct =
                                    await ProductAPI.addProduct(
                                            product: product)
                                        .whenComplete(() {
                                  setState(() {
                                    _btnController.success();
                                    Fluttertoast.showToast(
                                        msg: 'Product added successfully');
                                  });
                                });
                                Future.delayed(Duration(seconds: 5));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PdfPage(
                                            data: newProduct.productId,
                                          )),
                                );
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
                              print(e);
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
                    widget.currentProduct == null
                        ? SizedBox(
                            width: 0,
                          )
                        : Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: RoundedLoadingButton(
                              color: Colors.red,
                              child: Text('Delete',
                                  style: TextStyle(color: Colors.black)),
                              controller: _deleteController,
                              onPressed: () {
                                _deleteController.start();
                                try {
                                  showDialog(
                                    useRootNavigator: false,
                                    useSafeArea: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(
                                            context, widget.currentProduct),
                                  );
                                } catch (e) {
                                  _deleteController.error();
                                  Fluttertoast.showToast(
                                      msg: 'Failed to Delete Product');
                                }
                              },
                            ),
                          ),
                  ],
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
      ),
    );
  }

  Widget AlertContainer(StateSetter setState, BuildContext alertContext) {
    return Form(
      key: alertKey,
      child: SafeArea(
        child: Container(
          width: 600,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isFormEnabled
                  ? FormEnabled(setState, alertContext)
                  : FormDisabled(setState),
              Divider(
                height: 1,
                thickness: 3,
                color: Color(0xFFBDBDBD),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                  'Brands',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<th.Brand>>(
                  stream: ProductProvider.BrandRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<th.Brand> brands =
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      Brand brand;
                      brand = document.data();
                      brand.id = document.id;
                      return brand;
                    }).toList();
                    return Column(
                      children: List.generate(brands.length, (index) {
                        return BrandContainer(brands[index], setState);
                      }),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Padding FormEnabled(StateSetter setState, BuildContext alertContext) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          color: Color(0xFFd9d9d9),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  child: TextFormField(
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'name *',
                      labelStyle: FlutterFlowTheme.bodyText1,
                      hintText: 'name *',
                      hintStyle: FlutterFlowTheme.bodyText1,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      suffixIcon: textController1.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController1.clear(),
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.bodyText1,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'required';
                      }

                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  child: TextFormField(
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'image url *',
                      labelStyle: FlutterFlowTheme.bodyText1,
                      hintText: 'image url *',
                      hintStyle: FlutterFlowTheme.bodyText1,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      suffixIcon: textController2.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController2.clear(),
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.bodyText1,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'required';
                      }

                      return null;
                    },
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (alertKey.currentState.validate()) {
                          if (isEditingMode) {
                            await ProductProvider.BrandRef.doc(choosenBrand.id)
                                .update({
                              'name': textController1.text,
                              'imageUrl': textController2.text,
                            });
                            setState(() {
                              isEditingMode = false;
                              isFormEnabled = false;
                              textController2.clear();
                              textController1.clear();
                              choosenBrand = null;
                            });
                          } else {
                            await ProductProvider.BrandRef.add(th.Brand(
                                name: textController1.text,
                                imageUrl: textController2.text));
                            setState(() {
                              textController1.clear();
                              textController2.clear();
                              isFormEnabled = false;
                              isEditingMode = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF4EB1FF),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isFormEnabled = false;
                        isEditingMode = false;
                      });
                    },
                    child: Text(
                      'close',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.black)),
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFFd9d9d9),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding FormDisabled(StateSetter seState) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(50, 20, 20, 20),
      child: FFButtonWidget(
        onPressed: () {
          seState(() {
            isFormEnabled = true;
            isEditingMode = false;
          });
        },
        text: '+ New Brand',
        options: FFButtonOptions(
          width: 130,
          height: 40,
          color: Color(0xFF4EB1FF),
          textStyle: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 12,
        ),
      ),
    );
  }

  Future loadImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      // List<String> fileNames = result.files.map((e) => e.name).toList();
      UploadTask uploadTask;
      if (kIsWeb) {
        List<Uint8List> bytes = result.files.map((e) => e.bytes).toList();
        for (var i = 0; i < bytes.length; i++) {
          uploadTask = ProductAPI.uploadBytes(
              'products/${result.files[i].name}', bytes[i]);
          if (uploadTask != null) {
            final snapshot = await uploadTask.whenComplete(() {});
            final urlDownload = await snapshot.ref.getDownloadURL();
            setState(() {
              // Future.delayed(Duration(seconds: 3));
              imagesURL.add(urlDownload);
            });
          }
        }
      } else {
        List<File> files = List.generate(result.files.length, (index) {
          return File(result.files[index].path);
        });
        for (var i = 0; i < files.length; i++) {
          uploadTask = ProductAPI.uploadFile(
              'products/${result.files[i].name}', files[i]);
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
  }

  Widget _buildPopupDialog(BuildContext context, th.Product product) {
    return new CupertinoAlertDialog(
        title: Text(
            'Are you sure you want to delete this product: ${product.productId} ?'),
        actions: [
          TextButton(
            onPressed: () async {
              await ProductAPI.deleteProducts(product);
              Navigator.pop(context);
              _deleteController.success();
              Fluttertoast.showToast(msg: 'Product Deleted Successfully');
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteController.reset();
              },
              child: Text('Exit')),
        ]);
  }

  getData(String filter) {
    List<th.Brand> data = ProductProvider.of(context, listen: false)
        .initialBrands
        .where((element) => element.name == filter)
        .toList();

    if (data.length != 0) {
      return data;
    }

    return [];
  }

  Widget _customDropDownExample(BuildContext context, th.Brand selectedItem) {
    if (selectedItem == null) {
      return Container();
    }

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(
            // this does not work - throws 404 error
            // backgroundImage: NetworkImage(item.avatar ?? ''),
            ),
        title: Text(selectedItem.name),
        subtitle: Text(
          selectedItem.name,
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, th.Brand item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ListTile(
              selected: isSelected,
              title: Text(item?.name ?? ''),
            ),
          ),
        ],
      ),
    );
  }

  Widget BrandContainer(th.Brand brand, StateSetter setState) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 600,
            height: 2,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListTile(
              title: Text(
                brand.name,
                style: FlutterFlowTheme.subtitle2,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        textController1.text = brand.name;
                        textController2.text = brand.imageUrl;
                        isFormEnabled = true;
                        isEditingMode = true;
                        choosenBrand = brand;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Are you sure ?'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    brand.imageUrl,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(brand.name),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await ProductProvider.BrandRef.doc(brand.id)
                                        .delete();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: 'Brand Deleted Successfully');
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Exit')),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
              tileColor: Colors.white,
              dense: false,
            ),
          ),
        ],
      ),
    );
  }
}
