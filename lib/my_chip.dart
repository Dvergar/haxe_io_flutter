import 'package:flutter/material.dart';
import 'package:haxe_io_flutter/item_type.dart';

import 'grid_bloc.dart';

class MyChip extends StatefulWidget {
  final ItemView view;

  const MyChip({Key? key, required this.view}) : super(key: key);

  @override
  State<MyChip> createState() => _MyChipState();
}

class _MyChipState extends State<MyChip> {
  var isSelected = false;
  var grey = const Color.fromRGBO(189, 189, 189, 0.8);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(
          widget.view.typeLabel,
          style: TextStyle(color: isSelected ? widget.view.color : grey),
        ),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: BorderSide(color: isSelected ? widget.view.color : grey),
        ),
        selectedColor: widget.view.color.withOpacity(0.4),
        backgroundColor: Colors.transparent,
        selected: isSelected,
        onSelected: (_) {
          print("type ${widget.view}");
          setState(() {
            isSelected = !isSelected;
            gridBloc.sortBy(widget.view.type);
          });
        });
  }
}
