import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:admin_thrifters/customUI/buildDrawer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'buildDrawer.dart';

class CurrentScreen extends StatefulWidget {
  final Widget child;
  final String title;
  const CurrentScreen({Key key, @required this.child, @required this.title})
      : super(key: key);

  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          Fluttertoast.showToast(msg: 'Press again to exit', fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            widget.title,
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
            ),
          ),
          actions: [
            Icon(
              Icons.search_sharp,
              color: Colors.black,
              size: 24,
            )
          ],
          centerTitle: true,
          elevation: 1,
        ),
        backgroundColor: Color(0xffe5e5e5),
        drawer: buildDrawer(),
        body: widget.child,
      ),
    );
  }
}
