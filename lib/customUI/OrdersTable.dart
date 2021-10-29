import 'package:admin_thrifters/Screens/Products/EditProducts.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_widgets.dart';
import 'package:admin_thrifters/models/Order.dart';
import 'package:admin_thrifters/models/Product.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';

class OrdersTable extends StatefulWidget {
  final List<Order> orders;
  const OrdersTable({Key key, this.orders}) : super(key: key);

  @override
  _OrdersTableState createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
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
      _dessertsDataSource = DTS(context, widget.orders);
      _controller = PaginatorController();
      _initialized = true;
    }
  }

  void sort<T>(
    Comparable<T> Function(TableOrder d) getField,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            elevation: 11,
            child: PaginatedDataTable2(
              header: // Generated code for this Row Widget...
                  Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Filter orders',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          hintText: '[Some hint text...]',
                          hintStyle: FlutterFlowTheme.bodyText1.override(
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
                  ),
                  FlutterFlowDropDown(
                    options: ['Option 1'].toList(),
                    onChanged: (val) => setState(() => dropDownValue1 = val),
                    width: 130,
                    height: 40,
                    textStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    elevation: 2,
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    borderRadius: 0,
                    margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: FlutterFlowDropDown(
                      options: ['Option 1'].toList(),
                      onChanged: (val) => setState(() => dropDownValue2 = val),
                      width: 130,
                      height: 40,
                      textStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                      borderRadius: 0,
                      margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'More filters',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Saved',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Sort',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_dessertsDataSource.selectedRowCount > 0) {
                      List<Order> orders = [];
                      var orderies =
                          _dessertsDataSource.tableOrders.where((element) {
                        return element.selected == true;
                      });
                      orderies.forEach((tableOrder) {
                        orders.add(tableOrder.order);
                      });
                      Navigator.pushNamed(
                        context,
                        EditProducts.id,
                        arguments: orders,
                      );
                    }
                  },
                  child: Text(
                    'edit',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
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
                  label: Center(child: Text('Order')),
                  size: ColumnSize.L,
                  onSort: (columnIndex, ascending) => sort<String>(
                      (d) => d.order.orderID, columnIndex, ascending),
                ),
                DataColumn2(
                  label: Center(child: Text('Status')),
                  onSort: (columnIndex, ascending) => sort<String>(
                      (d) => d.order.status, columnIndex, ascending),
                ),
                DataColumn2(
                  label: Center(child: Text('Price')),
                  onSort: (columnIndex, ascending) =>
                      sort<num>((d) => d.order.price, columnIndex, ascending),
                ),
                DataColumn2(
                  label: Center(child: Text('Vendor')),
                  numeric: true,
                  onSort: (columnIndex, ascending) => sort<String>(
                      (d) => d.order.paymentMethod, columnIndex, ascending),
                ),
              ],
              source: _dessertsDataSource,
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
}

class DTS extends DataTableSource {
  final BuildContext context;
  List<TableOrder> tableOrders = [];
  List<Order> orders;

  DTS.empty(this.context) {
    tableOrders = [];
  }
  DTS(this.context, this.orders) {
    orders.forEach((order) {
      tableOrders?.add(TableOrder(order));
    });
  }

  void sort<T>(Comparable<T> Function(TableOrder p) getField, bool ascending) {
    tableOrders.sort((a, b) {
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
    for (var i = 0; i < tableOrders.length; i += 1) {
      var dessert = tableOrders[i];
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
    for (var i = 0; i < tableOrders.length; i += 1) {
      var dessert = tableOrders[i];
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
    final order = tableOrders[index];
    return DataRow.byIndex(
        index: index,
        selected: order.selected,
        onSelectChanged: (value) {
          if (order.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            order.selected = value;
            notifyListeners();
          }
        },
        cells: [
          DataCell(
            Center(child: Text(order.order.orderID)),
          ),
          DataCell(
            Center(child: Text(order.order.status)),
          ),
          DataCell(
            Center(child: Text(order.order.price.toString())),
          ),
          DataCell(
            Center(child: Text(order.order.paymentMethod)),
          ),
        ]);
  }

  @override
  int get rowCount => tableOrders?.length == 0 ? 0 : tableOrders?.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool checked) {
    for (final dessert in tableOrders) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? tableOrders.length : 0;
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
  void setDessertSelections(List<TableOrder> orders) {
    final updatedSet = <int>{};
    for (var i = 0; i < orders.length; i += 1) {
      var order = orders[i];
      if (order.selected) {
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

class TableOrder {
  TableOrder(this.order);

  final Order order;
  bool selected = false;
}
