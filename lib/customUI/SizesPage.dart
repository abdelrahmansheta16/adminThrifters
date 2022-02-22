import 'package:admin_thrifters/customUI/SizesList.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BrandsList.dart';

class SizesPage extends StatefulWidget {
  SizesPage({Key key}) : super(key: key);

  @override
  _SizesPageState createState() => _SizesPageState();
}

class _SizesPageState extends State<SizesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Sizes',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sizes')
              .orderBy('name')
              .withConverter<Size>(
                fromFirestore: (snapshot, _) => Size.fromJson(snapshot.data()),
                toFirestore: (size, _) => size.toJson(),
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<Size> sizes =
                snapshot.data.docs.map((DocumentSnapshot document) {
              Size size;
              size = document.data();
              return size;
            }).toList();
            return SizesList(
              sizes: sizes,
            );
          }),
    );
  }
}
