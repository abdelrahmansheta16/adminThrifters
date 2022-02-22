import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  static ProductProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<ProductProvider>(context, listen: listen);

  List<Product> _products = [];
  List<Product> get products => _products;
  List<Product> _filteredProducts = [];
  List<Product> get filteredProducts => _filteredProducts;
  List<String> _selectedCategories = [];
  List<String> get selectedCategories => _selectedCategories;
  List<Category> _initialCategories = [];
  List<Category> get initialCategories => _initialCategories;
  List<Size> _initialSizes = [];
  List<Size> get initialSizes => _initialSizes;
  List<Brand> _initialBrands = [];
  List<Brand> get initialBrands => _initialBrands;
  List<PriceRange> _initialPriceRanges = [];
  List<PriceRange> get initialPriceRanges => _initialPriceRanges;
  Brand _brand;
  Brand get brands => _brand;
  Size _size;
  Size get size => _size;

  static final CategoryRef = FirebaseFirestore.instance
      .collection('categories')
      .withConverter<Category>(
        fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()),
        toFirestore: (category, _) => category.toJson(),
      );
  static final ProductRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
            toFirestore: (product, _) => product.toJson(),
          );
  static final BrandRef =
      FirebaseFirestore.instance.collection('brands').withConverter<Brand>(
            fromFirestore: (snapshot, _) => Brand.fromJson(snapshot.data()),
            toFirestore: (brand, _) => brand.toJson(),
          );
  static final SizeRef =
      FirebaseFirestore.instance.collection('sizes').withConverter<Size>(
            fromFirestore: (snapshot, _) => Size.fromJson(snapshot.data()),
            toFirestore: (size, _) => size.toJson(),
          );
  static final PriceRangeRef = FirebaseFirestore.instance
      .collection('price ranges')
      .withConverter<PriceRange>(
        fromFirestore: (snapshot, _) => PriceRange.fromJson(snapshot.data()),
        toFirestore: (range, _) => range.toJson(),
      );

  void setProducts(List<Product> products) {
    _products.clear();
    products.forEach((element) {
      _products.add(element);
    });
    _filteredProducts.clear();
    products.forEach((element) {
      _filteredProducts.add(element);
    });
    notifyListeners();
  }

  Future<void> setCategories() async {
    _initialCategories = await CategoryRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  Future<void> setPriceRanges() async {
    _initialPriceRanges = await PriceRangeRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  Future<void> setSizes() async {
    _initialSizes = await SizeRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  Future<void> setBrands() async {
    _initialBrands = await BrandRef.get().then((querySnapshot) {
      return querySnapshot.docs.map((e) => e.data()).toList();
    });
    notifyListeners();
  }

  void updateBrands(Brand brand) {
    _brand = brand;
    notifyListeners();
  }

  void updateSizes(Size size) {
    _size = size;
    notifyListeners();
  }

  void updateCategories(List<String> categories) {
    _selectedCategories?.clear();
    categories.forEach((element) {
      _selectedCategories?.add(element);
    });
    notifyListeners();
  }

  void onQueryChanged(String query) {
    if (query.length == 0) {
      _filteredProducts.clear();
      _products.forEach((element) {
        _filteredProducts.add(element);
      });
    }
    _filteredProducts =
        _products.where((element) => element.productId == query).toList();
    notifyListeners();
  }

  addBrand(Brand brand) async {
    await BrandRef.add(brand);
    await setBrands();
    notifyListeners();
  }
}
