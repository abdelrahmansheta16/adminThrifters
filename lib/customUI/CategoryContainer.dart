import 'package:admin_thrifters/FirebaseAPI/ProductProvider.dart';
import 'package:admin_thrifters/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final List<String> categories;
  const CategoryContainer({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: List.generate(categories?.length, (index) {
                  String category = categories[index];
                  return Row(
                    children: [
                      Text(
                        category,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        index == categories.length - 1 ? '' : ' > ',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
      scrollDirection: Axis.horizontal,
    );
  }
}
