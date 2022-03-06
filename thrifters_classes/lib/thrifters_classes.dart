library thrifters_classes;

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'utils.dart';

List<USER> userFromJson(String str) =>
    List<USER>.from(json.decode(str).map((x) => USER.fromJson(x)));

String userToJson(List<USER> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Product {
  Product({
    this.productId,
    this.title,
    this.images,
    this.categories,
    this.description,
    this.brand,
    this.color,
    this.type,
    this.status,
    this.size,
    this.isSoldOut,
    this.isBackorder,
    this.isVisible,
    this.publishedAt,
    this.updatedAt,
    this.beforePrice,
    this.afterPrice,
    this.inventoryManagement,
    this.inventoryPolicy,
    this.taxable,
  });

  String productId;
  String title;
  List<String> images;
  List<String> categories;
  String description;
  Brand brand;
  List<String> color;
  String type;
  String status;
  Size size;
  bool isSoldOut;
  bool isBackorder;
  bool isVisible;
  DateTime publishedAt;
  DateTime updatedAt;
  num beforePrice;
  num afterPrice;
  bool inventoryManagement;
  bool inventoryPolicy;
  bool taxable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productID"],
        title: json["title"],
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : <String>[],
        categories: json["categories"] != null
            ? List<String>.from(json["categories"].map((x) => x))
            : <String>[],
        description: json["description"],
        brand: Brand.fromJson(json["brand"]),
        color: json["color"] != null
            ? List<String>.from(json["color"].map((x) => x))
            : <String>[],
        type: json["type"],
    status: json["status"],
        size: Size.fromJson(json["size"]),
        isSoldOut: json["isSoldOut"],
        isBackorder: json["isBackorder"],
        isVisible: json["isVisible"],
        publishedAt: Utils.toDateTime(json["publishedAt"]),
        updatedAt: Utils?.toDateTime(json["updatedAt"]),
        beforePrice: json["beforePrice"],
        afterPrice: json["afterPrice"],
        inventoryManagement: json["inventoryManagement"],
        inventoryPolicy: json["inventoryPolicy"],
        taxable: json["taxable"],
      );

  Map<String, dynamic> toJson() => {
        "productID": productId,
        "title": title,
        "images": images != null
            ? List<String>.from(images.map((x) => x))
            : <String>[],
        "categories": categories != null
            ? List<dynamic>.from(categories.map((x) => x))
            : <String>[],
        "description": description,
        "brand": brand.toJson(),
        "color":
            color != null ? List<String>.from(color.map((x) => x)) : <String>[],
        "type": type,
    "status": status,
        "size": size.toJson(),
        "isSoldOut": isSoldOut,
        "isBackorder": isBackorder,
        "isVisible": isVisible,
        "publishedAt": Utils.fromDateTimeToJson(publishedAt),
        "updatedAt": Utils.fromDateTimeToJson(updatedAt),
        "beforePrice": beforePrice,
        "afterPrice": afterPrice,
        "inventoryManagement": inventoryManagement,
        "inventoryPolicy": inventoryPolicy,
        "taxable": taxable,
      };
}

class Brand {
  Brand({
    this.id,
    this.name,
    this.imageUrl,
    this.isSelected = false,
  });

  String id;
  String name;
  String imageUrl;
  bool isSelected;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "isSelected": isSelected,
      };
}

class PriceRange {
  PriceRange({
    this.min,
    this.max,
    this.isSelected = false,
  });

  int min;
  int max;
  bool isSelected;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        min: json['min'],
        max: json['max'],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
        "isSelected": isSelected,
      };
}

class Size {
  Size({
    this.name,
    this.isSelected = false,
  });

  String name;
  bool isSelected;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        name: json["name"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isSelected": isSelected,
      };
}

class Category {
  Category({
    this.level,
    // this.products,
    this.name,
    this.subCategories,
    this.parentCategory,
    this.isExpanded = false,
    this.isSelected = false,
  });

  num level;
  // List<Product> products;
  String name;
  List<Category> subCategories;
  Category parent;
  String parentCategory;
  bool isExpanded;
  bool isSelected;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        level: json["level"],
        // products: json["products"] != null
        //     ? List<Product>.from(
        //         json["products"].map((x) => Product.fromJson(x)))
        //     : <Product>[],
        name: json["name"],
        subCategories: json["subCategories"] != null
            ? List<Category>.from(
                json["subCategories"].map((x) => Category.fromJson(x)))
            : <Category>[],
        parentCategory: json["parentCategory"],
        isExpanded: json["isExpanded"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        // "products": products != null
        //     ? List<dynamic>.from(products.map((x) => x.toJson()))
        //     : <Product>[],
        "name": name,
        "subCategories": subCategories != null
            ? List<dynamic>.from(subCategories.map((x) => x.toJson()))
            : <Category>[],
        "parentCategory": parentCategory,
        "isExpanded": isExpanded,
        "isSelected": isSelected,
      };
}

class Order {
  Order({
    this.orderID,
    this.user,
    this.address,
    this.products,
    this.discountApplied,
    this.creditApplied,
    this.shippingFee,
    this.subtotal,
    this.tax,
    this.status,
    this.paymentMethod,
    this.orderedOn,
    this.deliveredAt,
    this.price,
  });

  String orderID;
  USER user;
  Address address;
  List<Product> products;
  double discountApplied;
  double creditApplied;
  double shippingFee;
  double subtotal;
  double tax;
  double price;
  String status;
  String paymentMethod;
  DateTime orderedOn;
  DateTime deliveredAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderID: json["orderID"],
        user: USER.fromJson(json["user"]),
        address: Address.fromJson(json["address"]),
        products: json["products"] != null
            ? List<Product>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : <Product>[],
        discountApplied: json['isDiscountApplied'],
        creditApplied: json['isCreditApplied'],
        subtotal: json['subtotal'],
        tax: json['tax'],
        shippingFee: json["shippingFee"],
        status: json["status"],
        paymentMethod: json["paymentMethod"].toString(),
        orderedOn: Utils.toDateTime(json["orderedOn"]),
        deliveredAt: Utils.toDateTime(json["deliveredAt"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "orderID": orderID,
        "user": user.toJson(),
        "address": address.toJson(),
        "products": products != null
            ? List<dynamic>.from(products.map((x) => x.toJson()))
            : <Product>[],
        'discountApplied': discountApplied,
        'creditApplied': creditApplied,
        'subtotal': subtotal,
        'tax': tax,
        "shippingFee": shippingFee,
        "status": status,
        "paymentMethod": paymentMethod,
        "orderedOn": Utils.fromDateTimeToJson(orderedOn),
        "deliveredAt": Utils.fromDateTimeToJson(deliveredAt),
        "price": price,
      };
}

class Address {
  Address({
    this.addressID,
    this.area,
    this.streetName,
    this.buildingName,
    this.floorNumber,
    this.buildingType,
    this.location,
    this.addressName,
    this.apartmentNumber,
    this.phoneNumber,
    this.landline,
    this.landmark,
  });

  String addressID;
  String area;
  String streetName;
  String buildingName;
  String floorNumber;
  String apartmentNumber;
  String addressName;
  String landmark;
  String phoneNumber;
  String landline;
  GeoPoint location;
  String buildingType;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      addressID: json["AddressID"],
      area: json["Area"],
      streetName: json["StreetName"],
      buildingName: json["BuildingName"],
      floorNumber: json["floorNumber"],
      apartmentNumber: json["apartmentNumber"],
      addressName: json["addressName"],
      landmark: json["Landmark"],
      landline: json["Landline"],
      location: json["location"],
      phoneNumber: json["phoneNumber"],
      buildingType: json["buildingType"]
      // buildingType: BuildingType.values.firstWhere(
      //     (element) => element.toString() == json["buildingType"]),
      );

  Map<String, dynamic> toJson() => {
        "AddressID": addressID,
        "Area": area,
        "StreetName": streetName,
        "BuildingName": buildingName,
        "floorNumber": floorNumber,
        "addressName": addressName,
        "apartmentNumber": apartmentNumber,
        "Landline": landline,
        "Landmark": landmark,
        "phoneNumber": phoneNumber,
        "location": GeoPoint(location.latitude, location.longitude),
        "buildingType": buildingType,
      };
}

class USER {
  USER({
    this.userID,
    this.token,
    this.name,
    this.gender,
    this.phoneNumber,
    this.email,
    this.password,
    this.preferredStore,
    this.myBrands,
    this.cart,
    this.subscribed,
    this.rewardUsed = false,
    this.rewards,
    this.orders,
    this.returns,
    this.credit = 0.00,
    this.birthday,
    // this.addresses,
    this.cards,
  });

  String userID;
  String token;
  String name;
  String phoneNumber;
  String email;
  String myBrands;
  String password;
  bool subscribed;
  bool rewardUsed;
  String rewards;
  List<Product> cart;
  List<Product> returns;
  String gender;
  String preferredStore;
  List<Order> orders;
  double credit;
  DateTime birthday;
  // List<String> addresses;
  double cards;

  factory USER.fromJson(Map<String, dynamic> json) => USER(
        userID: json["userID"],
        token: json["token"],
        gender: json["gender"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        password: json["password"],
        myBrands: json["myBrands"],
        subscribed: json["subscribed"],
        rewardUsed: json["rewardUsed"],
        preferredStore: json["preferredStore"],
        rewards: json["rewards"],
        cart: json["cart"] != null
            ? List<Product>.from(json["cart"].map((x) => Product.fromJson(x)))
            : <Product>[],
        orders: json["orders"] != null
            ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
            : <Order>[],
        returns: json["returns"] != null
            ? List<Product>.from(
                json["returns"].map((x) => Product.fromJson(x)))
            : <Product>[],
        credit: json["credit"] != null ? json["credit"].toDouble() : 0.0,
        birthday: Utils.toDateTime(json["birthday"]),
        // addresses: json["addresses"] != null
        //     ? List<String>.from(json["addresses"].map((x) => x))
        //     : <String>[],
        cards: json["cards"] != null ? json["cards"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "token": token,
        "subscribed": subscribed,
        'rewardUsed': rewardUsed,
        "email": email,
        "password": password,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "name": name,
        "preferredStore": preferredStore,
        "myBrands": myBrands,
        "rewards": rewards,
        "cards": cards,
        "cart": cart != null
            ? List<dynamic>.from(cart.map((x) => x.toJson()))
            : <Product>[],
        "orders": orders != null
            ? List<dynamic>.from(orders.map((x) => x.toJson()))
            : <Order>[],
        "returns": returns != null
            ? List<dynamic>.from(returns.map((x) => x.toJson()))
            : <Product>[],
        "credit": credit,
        "birthday": Utils.fromDateTimeToJson(birthday),
        // "addresses": addresses != null
        //     ? List<String>.from(addresses.map((x) => x))
        //     : <String>[],
      };
}
//
// enum PreferredStore { Women, Men, Kids, Brands }
//
// enum Gender { Male, Female }
