import 'package:admin_thrifters/FirebaseAPI/ProductAPI.dart';
import 'package:admin_thrifters/Screens/Products/AddProduct.dart';
import 'package:admin_thrifters/Screens/Products/EditProducts.dart';
import 'package:admin_thrifters/customUI/ProductForm.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CategoryFilter.dart';
import 'buildDrawer.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class ProductsTable extends StatefulWidget {
  final List<Product> products;
  const ProductsTable({Key key, this.products}) : super(key: key);

  @override
  _ProductsTableState createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  String dropDownValue1;
  TextEditingController textController;
  String dropDownValue2;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int _sortColumnIndex;
  DTS _dessertsDataSource;
  bool _initialized = false;
  PaginatorController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _dessertsDataSource = DTS(context, widget.products);
      _controller = PaginatorController();
      _initialized = true;
    }
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        )
        .snapshots()
        .listen((event) {
      event.docChanges.forEach((element) {
        if (this.mounted) {
          Future.delayed(Duration(seconds: 5));
          setState(() {
            _dessertsDataSource = DTS(context, widget.products);
          });
        }
      });
    });
    super.initState();
  }

  void sort<T>(
    Comparable<T> Function(TableProduct d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertsDataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                elevation: 11,
                child: PaginatedDataTable2(
                  header: // Generated code for this Row Widget...
                      Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: TextFormField(
                      onChanged: (string) {
                        if (string.length == 0) {
                          setState(() {
                            _dessertsDataSource = DTS(context, widget.products);
                          });
                        }
                        if (string.length == 20) {
                          setState(() {
                            _dessertsDataSource = DTS(
                                context,
                                widget.products
                                    .where((element) =>
                                        element.productId == string)
                                    .toList());
                          });
                        }
                      },
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search products',
                        labelStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search_sharp,
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProduct()),
                        );
                      },
                      child: Text(
                        'Add Product',
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     if (_dessertsDataSource.selectedRowCount > 0) {
                    //       List<Product> products = [];
                    //       var producties = _dessertsDataSource.tableProducts
                    //           .where((element) {
                    //         return element.selected == true;
                    //       });
                    //       producties.forEach((tableProduct) {
                    //         products.add(tableProduct.product);
                    //       });
                    //       Navigator.pushNamed(
                    //         context,
                    //         EditProducts.id,
                    //         arguments: products,
                    //       );
                    //     }
                    //   },
                    //   child: Text(
                    //     'edit',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // )
                  ],
                  horizontalMargin: 20,
                  checkboxHorizontalMargin: 12,
                  columnSpacing: 0,
                  wrapInCard: true,
                  minWidth: 800,
                  rowsPerPage: _rowsPerPage,
                  fit: FlexFit.tight,
                  // border: TableBorder(
                  //     top: BorderSide(color: Colors.black),
                  //     bottom: BorderSide(color: Colors.grey[300]),
                  //     left: BorderSide(color: Colors.grey[300]),
                  //     right: BorderSide(color: Colors.grey[300]),
                  //     verticalInside: BorderSide(color: Colors.grey[300]),
                  //     horizontalInside: BorderSide(color: Colors.grey, width: 1)),
                  onRowsPerPageChanged: (value) {
                    // No need to wrap into setState, it will be called inside the widget
                    // and trigger rebuild
                    //setState(() {
                    _rowsPerPage = value;
                    print(_rowsPerPage);
                    //});
                  },
                  initialFirstRowIndex: 0,
                  onPageChanged: (rowIndex) {
                    print(rowIndex / _rowsPerPage);
                  },
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onSelectAll: _dessertsDataSource.selectAll,
                  controller: _controller,
                  columns: [
                    DataColumn2(
                      label: Center(child: Text('Product')),
                      size: ColumnSize.L,
                      onSort: (columnIndex, ascending) => sort<String>(
                          (d) => d.product.productId, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: Center(child: Text('Status')),
                      onSort: (columnIndex, ascending) => sort<String>(
                          (d) => d.product.description, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: Center(child: Text('Price')),
                      onSort: (columnIndex, ascending) => sort<num>(
                          (d) => d.product.beforePrice, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: Center(child: Text('Vendor')),
                      numeric: true,
                      onSort: (columnIndex, ascending) => sort<String>(
                          (d) => d.product.productId, columnIndex, ascending),
                    ),
                    // DataColumn2(
                    //   label: Center(child: Text('actions')),
                    //   // onSort: (columnIndex, ascending) => sort<String>(
                    //   //         (d) => d.product.productId, columnIndex, ascending),
                    // ),
                  ],
                  source: _dessertsDataSource,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// void onSort(int columnIndex, bool ascending) {
//   if (sortColumnIndex == 0) {
//     widget.products.sort((product1, product2) =>
//         compareString(isAscending, product1.productId, product2.productId));
//   } else if (sortColumnIndex == 1) {
//     widget.products.sort((product1, product2) =>
//         compareString(isAscending, product1.title, product2.title));
//   } else if (sortColumnIndex == 2) {
//     widget.products.sort((product1, product2) => compareString(
//         isAscending, product1.description, product2.description));
//   } else if (sortColumnIndex == 3) {
//     widget.products.sort((product1, product2) =>
//         compareString(isAscending, product1.price, product2.price));
//   }
//
//   setState(() {
//     this.sortColumnIndex = columnIndex;
//     this.isAscending = ascending;
//   });
// }
//
// int compareString(bool ascending, dynamic string, dynamic string2) {
//   return ascending ? string.compareTo(string2) : string2.compareTo(string);
// }
  void deleteProduct() {}
}

class DTS extends DataTableSource {
  final BuildContext context;
  List<TableProduct> tableProducts = [];
  List<Product> products;

  DTS.empty(this.context) {
    tableProducts = [];
  }
  DTS(this.context, this.products) {
    products.forEach((product) {
      tableProducts?.add(TableProduct(product));
    });
  }

  void sort<T>(
      Comparable<T> Function(TableProduct p) getField, bool ascending) {
    tableProducts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;
  void updateSelectedDesserts(RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < tableProducts.length; i += 1) {
      var dessert = tableProducts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  void updateSelectedDessertsFromSet(Set<int> selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < tableProducts.length; i += 1) {
      var dessert = tableProducts[i];
      if (selectedRows.contains(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    // assert(index >= 0);
    // if (index >= tableProducts.length) throw 'index > _desserts.length';
    final product = tableProducts[index];
    return DataRow.byIndex(
        index: index,
        selected: product.selected,
        onSelectChanged: (value) {
          if (product.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            product.selected = value;
            notifyListeners();
          }
        },
        cells: [
          DataCell(
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductForm(
                              currentProduct: product.product,
                            )),
                  );
                },
                child: Text(
                  product.product.productId,
                ),
              ),
            ),
          ),
          DataCell(
            Center(child: Text(product.product.description)),
          ),
          DataCell(
            Center(child: Text(product.product.beforePrice.toString())),
          ),
          DataCell(
            Center(child: Text(product.product.productId)),
          ),
          // DataCell(
          //   Center(
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         IconButton(
          //           icon: Icon(
          //             Icons.remove_red_eye_outlined,
          //             color: Colors.blue,
          //             size: 15,
          //           ),
          //           onPressed: () {
          //             print('IconButton pressed ...');
          //           },
          //         ),
          //         IconButton(
          //           icon: Icon(
          //             Icons.edit_sharp,
          //             color: Colors.blue,
          //             size: 15,
          //           ),
          //           onPressed: () {
          //             print('IconButton pressed ...');
          //           },
          //         ),
          //         IconButton(
          //           icon: Icon(
          //             Icons.delete_sharp,
          //             color: Colors.blue,
          //             size: 15,
          //           ),
          //           onPressed: () async {
          //             _buildPopupDialog(context, product.product);
          //           },
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ]);
  }

  @override
  int get rowCount => tableProducts?.length == 0 ? 0 : tableProducts?.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool checked) {
    for (final dessert in tableProducts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? tableProducts.length : 0;
    notifyListeners();
  }

//
// Widget action() {
//   int selected = 0;
//   tableProducts.forEach((product) {
//     if (product.selected) {
//       selected++;
//     }
//   });
//   print(selected);
//   if (selected > 0) {
//     return Icon(Icons.menu_sharp);
//   }
//   return null;
// }

// @override
// DataRow getRow(int index) {
//   Product product = products[index];
//   return DataRow.byIndex(
//       selected: _dataTableState().selectedProducts.contains(product),
//       onSelectChanged: (isSelected) => _dataTableState().setState(() {
//             final isAdding = isSelected != null && isSelected;
//
//             isAdding
//                 ? _dataTableState().selectedProducts.add(product)
//                 : _dataTableState().selectedProducts.remove(product);
//           }),
//       cells: [
//         DataCell(
//           Text(product.productId),
//         ),
//         DataCell(
//           Text(product?.title),
//         ),
//         DataCell(
//           Text(product.productId),
//         ),
//         DataCell(
//           Text(product.price.toString()),
//         ),
//       ]);
// }
//
// @override
// // TODO: implement isRowCountApproximate
// bool get isRowCountApproximate => false;
//
// @override
// // TODO: implement rowCount
// int get rowCount => products.length;
//
// @override
// // TODO: implement selectedRowCount
// int get selectedRowCount => throw UnimplementedError();
}

class RestorableDessertSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  /// Takes a list of [Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<TableProduct> products) {
    final updatedSet = <int>{};
    for (var i = 0; i < products.length; i += 1) {
      var product = products[i];
      if (product.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

class TableProduct {
  TableProduct(this.product);

  final Product product;
  bool selected = false;
}
