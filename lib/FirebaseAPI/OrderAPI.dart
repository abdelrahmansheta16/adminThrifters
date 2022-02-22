import 'package:admin_thrifters/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin_thrifters/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class OrderAPI with ChangeNotifier {
  List<Product> products = [];
  Address address = new Address();
  String method;
  double Price;
  // static final UsersRef =
  //     FirebaseFirestore.instance.collection('users').withConverter<USER>(
  //           fromFirestore: (snapshot, _) => USER.fromJson(snapshot.data()),
  //           toFirestore: (user, _) => user.toJson(),
  //         );

  void addAddress(Address value) {
    if (address == null) {
      address = value;
    }
    notifyListeners();
  }

  void addProducts(List<Product> value) {
    products?.clear();
    products?.addAll(value);
    Price = 0;
    value.forEach((product) {
      Price += product.beforePrice;
    });
    notifyListeners();
  }

  void addPaymentMethod(String value) {
    method = value;
    notifyListeners();
  }

  double getSubtotal(List<Product> products) {
    double subtotal = 0;
    products?.forEach((product) {
      subtotal += product.beforePrice;
    });
    return subtotal;
  }

  double getTax(List<Product> products) {
    double tax = 0;
    tax = getSubtotal(products) * 0.14;
    return tax;
  }

  double totalPrice(List<Product> products) {
    double totalPrice = 0;
    totalPrice = getSubtotal(products) + getTax(products) + 15;
    Price = totalPrice;
    return totalPrice;
  }

  Future addOrder({Order currentOrder, String userID}) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/orders')
        .withConverter<Order>(
          fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
          toFirestore: (order, _) => order.toJson(),
        );
    await UsersRef.add(currentOrder);
    await UserAPI.clearCart();
  }

  static Stream<QuerySnapshot> loadOrders() {
    final UsersRef =
        FirebaseFirestore.instance.collection('orders').withConverter<Order>(
              fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
              toFirestore: (order, _) => order.toJson(),
            );
    Stream<QuerySnapshot<Order>> orders = UsersRef.snapshots();
    return orders;
  }

  // static Stream<QuerySnapshot<USER>> loadOrders() {
  //   Stream<QuerySnapshot<USER>> users = UsersRef.snapshots();
  //   // .map((snapshot) => snapshot.docs.forEach((element) {
  //   //       OrderAPI.UsersRef.doc(element.id)
  //   //           .collection('orders')
  //   //           .withConverter<Order>(
  //   //             fromFirestore: (snapshot, _) =>
  //   //                 Order.fromJson(snapshot.data()),
  //   //             toFirestore: (order, _) => order.toJson(),
  //   //           )
  //   //           .get()
  //   //           .then((value) => value.docs.forEach((element) {
  //   //                 Order order;
  //   //                 order = element.data();
  //   //                 order.orderID = element.id;
  //   //                 orders.add(order);
  //   //               }));
  //   //     }));
  //
  //   // Stream<QuerySnapshot<Order>> orders =
  //   //     UsersRef.snapshots().map((event) => event.docs.map((element) {
  //   //           return UsersRef.doc(element.id)
  //   //               .collection('orders')
  //   //               .withConverter<Order>(
  //   //                 fromFirestore: (snapshot, _) =>
  //   //                     Order.fromJson(snapshot.data()),
  //   //                 toFirestore: (order, _) => order.toJson(),
  //   //               )
  //   //               .snapshots();
  //   //         }));
  //   // Future users =
  //   //     UsersRef.get().then((value) => value.docs);
  //
  //   return users;
  // }
}
