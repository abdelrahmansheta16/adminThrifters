import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductAPI {
  static final ProductsRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
            toFirestore: (product, _) => product.toJson(),
          );

  static final CategoryRef = FirebaseFirestore.instance
      .collection('categories')
      .withConverter<Category>(
        fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()),
        toFirestore: (category, _) => category.toJson(),
      );

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

  static Stream<QuerySnapshot<Product>> loadProducts() {
    Stream<QuerySnapshot<Product>> products = ProductsRef.snapshots();
    return products;
  }

  static Future<Product> addProduct({Product product}) async {
    List<String> categories = product.categories;
    // List<String> names = categories.map((e) => e.name).toList();
    Category category = await CategoryRef.doc('women').get().then((value) {
      return value.data();
    });
    Product newProduct;
    await ProductsRef.add(product).then((value) {
      product.productId = value.id;
      newProduct = product;
      ProductsRef.doc(value.id).set(product);
      return null;
    });
    // category = searchCategory(category, product, names);
    // CategoryRef.doc('women').set(category);
    return newProduct;
    // CategoryRef.get().then((value) {
    //   value.docs.map((DocumentSnapshot document) {
    //     Category category;
    //     category = document.data();
    //     Product product;
    //     searchCategory(category, product, names);
    //   });
    // });
  }

  static Future setProducts({Product product}) async {
    await ProductsRef.doc(product.productId).set(
      product,
      SetOptions(merge: true),
    );
  }

  static Future<void> deleteProducts(Product product) async {
    await ProductsRef.doc(product.productId).delete();
  }

  static Stream<QuerySnapshot<Category>> loadCategories() {
    Stream<QuerySnapshot<Category>> categories = CategoryRef.snapshots();
    return categories;
  }

  // static Category searchCategory(
  //     Category category, Product product, List<String> names) {
  //   if (names.contains(category.name)) {
  //     String name =
  //         names.where((element) => names.contains(category.name)).toString();
  //     category.products.add(product);
  //   }
  //   category.subCategories.forEach((first) {
  //     if (names.contains(first.name)) {
  //       first.products.add(product);
  //     }
  //     if (first.subCategories.length != 0) {
  //       first.subCategories.forEach((element) {
  //         searchCategory(element, product, names);
  //       });
  //     }
  //   });
  //   return category;
  // }
}
