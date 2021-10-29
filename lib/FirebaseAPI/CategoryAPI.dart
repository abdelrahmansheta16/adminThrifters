import 'package:admin_thrifters/models/Category.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier {
  static CategoryProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<CategoryProvider>(context, listen: listen);

  List<Category> _selectedCategories = [];

  List<Category> get selectedCategories => _selectedCategories;

  void updateList(List<Category> categories) {
    _selectedCategories?.clear();
    categories.forEach((element) {
      _selectedCategories?.add(element);
    });
    notifyListeners();
  }
}
