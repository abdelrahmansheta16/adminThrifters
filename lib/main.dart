import 'dart:async';

import 'package:admin_thrifters/FirebaseAPI/FirebaseMessaging.dart';
import 'package:admin_thrifters/FirebaseAPI/ProductProvider.dart';
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
import 'package:admin_thrifters/Screens/Products/EditProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:admin_thrifters/Screens/Products/AllProducts.dart';
import 'package:admin_thrifters/Screens/Products/Collections.dart';
import 'package:admin_thrifters/Screens/Products/GiftCards.dart';
import 'package:admin_thrifters/Screens/Products/Inventory.dart';
import 'package:admin_thrifters/Screens/Products/Transfers.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_thrifters/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Import the generated file
// import 'firebase_options.dart';
import 'Screens/Analysis/Reports.dart';
import 'Screens/MainScreen.dart';
import 'Screens/Products/AddProduct.dart';

String initialRoute;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
String adminToken ;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = LoginScreen.id;
    } else {
      initialRoute = MainScreen.id;
    }
  });

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  adminToken = await FirebaseMessaging.instance.getToken();

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
      ledColor: Colors.teal,
      enableLights: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductProvider()),
        ],
        child: MyApp(),
      ),
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
    // NotificationAPI.init();
    // NotificationAPI.requestPermissions();
    // listenNotifications();
    FirebaseFirestore.instance.collection('admins').doc('YZIQg1bJZ8S9MWQg1RvimE3xmmO2').update({
      'token':adminToken,
    });
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    BackgroundMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message: ${message.data}');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                // icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   Orders.id,
      // );
      // arguments: MessageArguments(message, true));
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print('A new getInitialMessage event was published!');
      // Navigator.pushNamed(
      //   context,
      //   Orders.id,
      // );
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
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
    // Order order;
    // final reference =
    //     FirebaseFirestore.instance.collection('orders').withConverter<Order>(
    //           fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
    //           toFirestore: (order, _) => order.toJson(),
    //         );
    // reference.snapshots().listen((event) {
    //   if (event.docChanges.last.type == DocumentChangeType.added) {
    //     event.docChanges.forEach((element) {
    //       order = element.doc.data();
    //       print(order.orderID);
    //       NotificationAPI.showNotification(
    //           title: order.orderID,
    //           body: order.price.toString(),
    //           payload: order.paymentMethod);
    //     });
    //   }
    // });
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
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
        AllProducts.id: (context) => AllProducts(),
        EditProducts.id: (context) => EditProducts(),
        AddProduct.id: (context) => AddProduct(),
        Collection.id: (context) => Collection(),
        GiftCards.id: (context) => GiftCards(),
        Inventory.id: (context) => Inventory(),
        Transfers.id: (context) => Transfers(),
        Customers.id: (context) => Customers(),
        Discounts.id: (context) => Discounts(),
      },
    );
  }

  // void printReceipt(Order data) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => pd.PdfPage(
  //               data: data.orderID,
  //             )),
  //   );
  // }
  //
  // void listenNotifications() {
  //   NotificationAPI.selectNotificationSubject.stream
  //       .listen(onClickedNotification);
  // }
  //
  // void onClickedNotification(String payload) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Container()),
  //   );
  // }
}
