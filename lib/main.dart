import 'dart:async';

import 'package:admin_thrifters/Screens/Analysis/Dashboards.dart';
import 'package:admin_thrifters/Screens/Analysis/LiveView.dart';
import 'package:admin_thrifters/Screens/Customers.dart';
import 'package:admin_thrifters/Screens/Discounts.dart';
import 'package:admin_thrifters/Screens/Marketing/Automations.dart';
import 'package:admin_thrifters/Screens/Marketing/Campaigns.dart';
import 'package:admin_thrifters/Screens/Marketing/Overview.dart';
import 'package:admin_thrifters/Screens/Orders/AbandonedCheckouts.dart';
import 'package:admin_thrifters/Screens/Orders/Drafts.dart';
import 'package:admin_thrifters/Screens/Orders/Orders.dart';
import 'package:admin_thrifters/Screens/Products/AddProduct..dart';
import 'package:admin_thrifters/Screens/Products/AllProducts.dart';
import 'package:admin_thrifters/Screens/Products/Collections.dart';
import 'package:admin_thrifters/Screens/Products/GiftCards.dart';
import 'package:admin_thrifters/Screens/Products/Inventory.dart';
import 'package:admin_thrifters/Screens/Products/Transfers.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_thrifters/Screens/LoginScreen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Screens/Analysis/Reports.dart';
import 'Screens/MainScreen.dart';

String initialRoute;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = LoginScreen.id;
    } else {
      initialRoute = MainScreen.id;
    }
  });
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  bool allowClose = false;

  DateTime get timeBackPressed => DateTime.now();

  Widget _buildPopupDialog(BuildContext context) {
    return new CupertinoAlertDialog(
        title: const Text('Connect to the Internet'),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await initConnectivity();
              },
              child: Text('Retry')),
          TextButton(
              onPressed: ({bool animated}) async {
                await SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop', animated);
              },
              child: Text('Exit')),
        ]);
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        setState(() {
          _connectionStatus = result;
          showDialog(
            useRootNavigator: false,
            useSafeArea: false,
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        });
        print(_connectionStatus);
        break;
      default:
        setState(() => _connectionStatus = ConnectivityResult.none);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Provider Demo',
      initialRoute: initialRoute,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        Dashboards.id: (context) => Dashboards(),
        LiveView.id: (context) => LiveView(),
        Reports.id: (context) => Reports(),
        Automations.id: (context) => Automations(),
        Campaigns.id: (context) => Campaigns(),
        Overview.id: (context) => Overview(),
        AbandonedCheckouts.id: (context) => AbandonedCheckouts(),
        Drafts.id: (context) => Drafts(),
        Orders.id: (context) => Orders(),
        AddProduct.id: (context) => AddProduct(),
        AllProducts.id: (context) => AllProducts(),
        Collection.id: (context) => Collection(),
        GiftCards.id: (context) => GiftCards(),
        Inventory.id: (context) => Inventory(),
        Transfers.id: (context) => Transfers(),
        Customers.id: (context) => Customers(),
        Discounts.id: (context) => Discounts(),
      },
    );
  }
}
