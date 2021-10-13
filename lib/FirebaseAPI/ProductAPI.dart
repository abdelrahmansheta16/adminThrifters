import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_thrifters/models/Product.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utils.dart';

class ProductAPI {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static final ProductsRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
            toFirestore: (product, _) => product.toJson(),
          );

  static Stream<QuerySnapshot<Product>> loadProducts() {
    Stream<QuerySnapshot<Product>> products = ProductsRef.snapshots();
    return products;
  }

  static Future addProducts({Product product}) async {
    await ProductsRef.add(product);
  }
}
