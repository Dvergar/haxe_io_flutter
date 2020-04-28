import 'package:flutter/material.dart';

class MyChip extends StatefulWidget {
  final Color color;
  final String label;

  MyChip({Key key, @required this.label, @required this.color}) : super(key: key);

  @override
  _MyChipState createState() => _MyChipState();
}

class _MyChipState extends State<MyChip> {
  var isSelected = false;
  var grey = Color.fromRGBO(189, 189, 189, 0.8);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(
          widget.label,
          style: TextStyle(color: isSelected ? widget.color : grey),
        ),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: isSelected ? widget.color : grey)),
        selectedColor: widget.color.withOpacity(0.4),
        backgroundColor: Colors.transparent,
        selected: this.isSelected,
        onSelected: (_) {
          setState(() {
            isSelected = !isSelected;
          });
        });
  }
}
