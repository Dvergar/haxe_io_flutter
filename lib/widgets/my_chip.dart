import 'package:flutter/material.dart';

import '../grid_bloc.dart';
import '../item_type.dart';

class MyChip extends StatefulWidget {
  final ItemType type;

  const MyChip({super.key, required this.type});

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
          widget.type.label,
          style: TextStyle(
            color: isSelected ? widget.type.color : grey,
          ),
        ),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: BorderSide(
            color: isSelected ? widget.type.color : grey,
          ),
        ),
        selectedColor: widget.type.color.withOpacity(0.4),
        backgroundColor: Colors.transparent,
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            isSelected = !isSelected;
            gridBloc.sortBy(widget.type);
          });
        });
  }
}
