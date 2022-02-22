import 'package:admin_thrifters/FirebaseAPI/ProductProvider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:flutter/material.dart';

class SizesList extends StatefulWidget {
  final List<Size> sizes;
  const SizesList({Key key, this.sizes}) : super(key: key);

  @override
  _SizesListState createState() => _SizesListState();
}

class _SizesListState extends State<SizesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: List.generate(widget.sizes.length, (index) {
        Size currentSize = widget.sizes[index];
        return ListTile(
          selected: currentSize.isSelected,
          onTap: () {
            setState(() {
              updateSelected(widget.sizes);
              currentSize.isSelected = !currentSize.isSelected;
            });
            ProductProvider.of(context, listen: false).updateSizes(currentSize);
          },
          title: Text(
            currentSize.name,
            style: TextStyle(
              color: currentSize.isSelected ? Color(0xFF1D9E6A) : Colors.black,
            ),
          ),
          trailing: currentSize.isSelected
              ? Icon(
                  Icons.check_sharp,
                  color: Color(0xFF1D9E6A),
                )
              : Icon(Icons.keyboard_arrow_right_sharp),
        );
      }),
    );
  }

  void updateSelected(List<Size> sizes) {
    sizes.forEach((element) {
      element.isSelected = false;
    });
  }
}
