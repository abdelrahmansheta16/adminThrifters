import 'package:admin_thrifters/FirebaseAPI/ProductProvider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:flutter/material.dart';

class BrandsList extends StatefulWidget {
  final List<Brand> brands;
  const BrandsList({Key key, this.brands}) : super(key: key);

  @override
  _BrandsListState createState() => _BrandsListState();
}

class _BrandsListState extends State<BrandsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: List.generate(widget.brands.length, (index) {
        Brand currentBrand = widget.brands[index];
        return ListTile(
          selected: currentBrand.isSelected,
          onTap: () {
            setState(() {
              updateSelected(widget.brands);
              currentBrand.isSelected = !currentBrand.isSelected;
            });
            ProductProvider.of(context, listen: false)
                .updateBrands(currentBrand);
          },
          title: Text(
            currentBrand.name,
            style: TextStyle(
              color: currentBrand.isSelected ? Color(0xFF1D9E6A) : Colors.black,
            ),
          ),
          trailing: currentBrand.isSelected
              ? Icon(
                  Icons.check_sharp,
                  color: Color(0xFF1D9E6A),
                )
              : Icon(Icons.keyboard_arrow_right_sharp),
        );
      }),
    );
  }

  void updateSelected(List<Brand> brands) {
    brands.forEach((element) {
      element.isSelected = false;
    });
  }
}
