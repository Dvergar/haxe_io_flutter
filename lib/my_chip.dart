import 'package:flutter/material.dart';
import 'package:haxe_roundups_flutter/item_type.dart';

import 'grid_bloc.dart';

class MyChip extends StatefulWidget {
  final ItemType type;

  MyChip({Key key, @required this.type}) : super(key: key);

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
          widget.type.typeLabel,
          style: TextStyle(color: isSelected ? widget.type.color : grey),
        ),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: isSelected ? widget.type.color : grey)),
        selectedColor: widget.type.color.withOpacity(0.4),
        backgroundColor: Colors.transparent,
        selected: this.isSelected,
        onSelected: (_) {
          print("type ${widget.type}");
          setState(() {
            isSelected = !isSelected;
            gridBloc.sortBy(widget.type);
          });
        });
  }
}
