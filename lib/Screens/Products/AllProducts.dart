import 'package:admin_thrifters/FirebaseAPI/ProductAPI.dart';
import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:admin_thrifters/customUI/ProductsTable.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_widgets.dart';
import 'package:admin_thrifters/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      title: 'All Products',
      // child: Padding(
      //   padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
      //             child: Text(
      //               'Products',
      //               style: FlutterFlowTheme.bodyText1.override(
      //                 fontFamily: 'Poppins',
      //                 fontSize: 24,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
      //             child: FFButtonWidget(
      //               onPressed: () {
      //                 print('Button pressed ...');
      //               },
      //               text: 'Add Product',
      //               options: FFButtonOptions(
      //                 width: 130,
      //                 height: 40,
      //                 color: Color(0xFF50B28D),
      //                 textStyle: FlutterFlowTheme.subtitle2.override(
      //                   fontFamily: 'Poppins',
      //                   color: Colors.white,
      //                 ),
      //                 borderSide: BorderSide(
      //                   color: Colors.transparent,
      //                   width: 1,
      //                 ),
      //                 borderRadius: 12,
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       Card(
      //         clipBehavior: Clip.antiAliasWithSaveLayer,
      //         color: Color(0xFFF5F5F5),
      //         elevation: 11,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Padding(
      //           padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
              return product;
            }).toList();
            return ProductsTable(products: products);
          }),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
