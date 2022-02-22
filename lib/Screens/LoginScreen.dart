import 'package:admin_thrifters/Screens/MainScreen.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
  static final id = '/LoginScreen';
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddressController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  DateTime timeBackPressed = DateTime.now();
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

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
      child: ModalProgressHUD(
        inAsyncCall: isActive,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF4B39EF),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Color(0xFF4B39EF),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Thrifters United',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Roboto Mono',
                                    color: Colors.white,
                                    fontSize: 35,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (email) {
                                      if (email.isEmpty) {
                                        return 'Please input a valid email';
                                      }
                                      return null;
                                    },
                                    controller: emailAddressController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      labelStyle:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      hintText: 'Enter your email...',
                                      hintStyle:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF3124A1),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 24, 20, 24),
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 12, 20, 0),
                                  child: TextFormField(
                                    validator: (password) {
                                      if (password.isEmpty) {
                                        return 'Please input a valid password';
                                      }
                                      if (password.length < 8) {
                                        return 'minimum required characters are 8';
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    obscureText: !passwordVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      hintText: 'Enter your password...',
                                      hintStyle:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0x98FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF3124A1),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 24, 20, 24),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => passwordVisibility =
                                              !passwordVisibility,
                                        ),
                                        child: Icon(
                                          passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0x98FFFFFF),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        setState(() {
                                          isActive = true;
                                        });
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('admins')
                                              .where('email',
                                                  isEqualTo:
                                                      emailAddressController
                                                          .text)
                                              .where('password',
                                                  isEqualTo:
                                                      passwordController.text)
                                              .get()
                                              .catchError((onError) {
                                            print(onError.toString());
                                            setState(() {
                                              isActive = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: onError,
                                                toastLength: Toast.LENGTH_LONG,
                                                timeInSecForIosWeb: 3,
                                                webPosition: "center");
                                          }).then((QuerySnapshot
                                                  querySnapshot) {
                                            if (querySnapshot.docs.length !=
                                                0) {
                                              querySnapshot.docs
                                                  .forEach((admin) async {
                                                if (admin.exists) {
                                                  print(admin.data());
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email:
                                                              emailAddressController
                                                                  .text,
                                                          password:
                                                              passwordController
                                                                  .text)
                                                      .catchError((error) {
                                                    print(error);
                                                    setState(() {
                                                      isActive = false;
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg: error.toString(),
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        timeInSecForIosWeb: 5,
                                                        webPosition: "center");
                                                  });
                                                  setState(() {
                                                    isActive = false;
                                                  });
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          MainScreen.id,
                                                          (route) => false);
                                                }
                                              });
                                            } else {
                                              setState(() {
                                                isActive = false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Invalid username or password',
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  timeInSecForIosWeb: 3,
                                                  webPosition: "center");
                                            }
                                          }).catchError((onError) {
                                            print(onError.toString());
                                            setState(() {
                                              isActive = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: onError,
                                                toastLength: Toast.LENGTH_LONG,
                                                timeInSecForIosWeb: 3,
                                                webPosition: "center");
                                          });
                                        } catch (e) {
                                          print(e);
                                          setState(() {
                                            isActive = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: e.toString(),
                                              toastLength: Toast.LENGTH_LONG,
                                              timeInSecForIosWeb: 3,
                                              webPosition: "center");
                                        }
                                      }
                                    },
                                    text: 'Login',
                                    options: FFButtonOptions(
                                      width: 230,
                                      height: 60,
                                      color: Colors.white,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF4B39EF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 8,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print(
                                          'Button-ForgotPassword pressed ...');
                                    },
                                    text: 'Forgot Password?',
                                    options: FFButtonOptions(
                                      width: 170,
                                      height: 40,
                                      color: Color(0xFF4B39EF),
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
