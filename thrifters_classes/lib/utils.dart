import 'dart:async';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static Future<List<Brand>> getSuggestions(String query) {
    return FirebaseFirestore.instance
        .collection('brands')
        .orderBy('name')
        .withConverter<Brand>(
          fromFirestore: (snapshot, _) => Brand.fromJson(snapshot.data()),
          toFirestore: (brand, _) => brand.toJson(),
        )
        .get()
        .then((value) => value.docs
            .map((e) => e.data())
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }
}
// static Map<String, dynamic> birthdayToDateTime(Date value) {
//   // if (value == null) return null;
//
//   return value?.toJson();
// }
//
// static dynamic birthdayFromDateTimeToJson(Date date) {
//   if (date == null) return null;
//
//   return DateTime(date.year, date.month, date.day).toUtc();
// }
