import 'package:admin_thrifters/Screens/Customers.dart';
import 'package:admin_thrifters/Screens/MainScreen.dart';
import 'package:admin_thrifters/Screens/Products/AddProduct..dart';
import 'package:admin_thrifters/Screens/Products/Inventory.dart';
import 'package:flutter/material.dart';

import 'package:admin_thrifters/Screens/Analysis/Dashboards.dart';
import 'package:admin_thrifters/Screens/Analysis/LiveView.dart';
import 'package:admin_thrifters/Screens/Analysis/Reports.dart';
import 'package:admin_thrifters/Screens/Discounts.dart';
import 'package:admin_thrifters/Screens/Marketing/Automations.dart';
import 'package:admin_thrifters/Screens/Marketing/Campaigns.dart';
import 'package:admin_thrifters/Screens/Marketing/Overview.dart';
import 'package:admin_thrifters/Screens/Orders/AbandonedCheckouts.dart';
import 'package:admin_thrifters/Screens/Orders/Drafts.dart';
import 'package:admin_thrifters/Screens/Orders/Orders.dart';
import 'package:admin_thrifters/Screens/Products/AllProducts.dart';
import 'package:admin_thrifters/Screens/Products/Collections.dart';
import 'package:admin_thrifters/Screens/Products/GiftCards.dart';
import 'package:admin_thrifters/Screens/Products/Transfers.dart';

class buildDrawer extends StatefulWidget {
  const buildDrawer({Key key}) : super(key: key);

  @override
  _buildDrawerState createState() => _buildDrawerState();
}

class _buildDrawerState extends State<buildDrawer> {
  bool _marketingTileExpanded = false;
  bool _ordersTileExpanded = false;
  bool _productsTileExpanded = false;
  bool _analysisTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 16,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xfff7f7f7),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/icon.png',
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home_outlined),
                        title: Text('Home'),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, MainScreen.id, (route) => false);
                        },
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.save_alt_sharp),
                        title: const Text('Orders'),
                        trailing: _ordersTileExpanded
                            ? Icon(Icons.arrow_drop_down_circle,
                                color: Colors.black)
                            : Icon(
                                Icons.arrow_drop_down,
                              ),
                        children: [
                          ListTile(
                            leading: SizedBox(),
                            title: Text(
                              'Orders',
                              textAlign: TextAlign.left,
                            ),
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Orders.id, (route) => false);
                            },
                          ),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Drafts.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Drafts',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AbandonedCheckouts.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Abandoned checkouts',
                                textAlign: TextAlign.left,
                              )),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() => _ordersTileExpanded = expanded);
                        },
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.shopping_bag_sharp),
                        title: const Text('Products'),
                        trailing: _productsTileExpanded
                            ? Icon(Icons.arrow_drop_down_circle,
                                color: Colors.black)
                            : Icon(
                                Icons.arrow_drop_down,
                              ),
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AllProducts.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'All Products',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AddProduct.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Add Products',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Inventory.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Inventory',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Transfers.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Transfers',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, GiftCards.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Gift Cards',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Collection.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Collections',
                                textAlign: TextAlign.left,
                              )),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() => _productsTileExpanded = expanded);
                        },
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Customers.id, (route) => false);
                        },
                        leading: Icon(Icons.account_circle_sharp),
                        title: Text('Costumers'),
                      ),
                      ExpansionTile(
                        leading: Icon(Icons.analytics_outlined),
                        title: const Text('Analysis'),
                        trailing: _analysisTileExpanded
                            ? Icon(Icons.arrow_drop_down_circle,
                                color: Colors.black)
                            : Icon(
                                Icons.arrow_drop_down,
                              ),
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Dashboards.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Dashboards',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Reports.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Reports',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, LiveView.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Live view',
                                textAlign: TextAlign.left,
                              )),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() => _analysisTileExpanded = expanded);
                        },
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.speaker_phone_outlined),
                        title: const Text('Marketing'),
                        trailing: _marketingTileExpanded
                            ? Icon(Icons.arrow_drop_down_circle,
                                color: Colors.black)
                            : Icon(
                                Icons.arrow_drop_down,
                              ),
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Overview.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Overview',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Campaigns.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Campaigns',
                                textAlign: TextAlign.left,
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Automations.id, (route) => false);
                              },
                              leading: SizedBox(),
                              title: Text(
                                'Automations',
                                textAlign: TextAlign.left,
                              )),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() => _marketingTileExpanded = expanded);
                        },
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Discounts.id, (route) => false);
                        },
                        leading: Icon(Icons.style_sharp),
                        title: Text('Discounts'),
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Settings'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
