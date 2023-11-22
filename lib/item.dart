import 'package:haxe_io_flutter/item_type.dart';

class Item {
  final ItemType type;
  final String label;
  final String url;
  final bool markdown;
  final String? jsonUrl;

  Item({
    required this.type,
    required this.label,
    required this.url,
    required this.markdown,
    this.jsonUrl,
  });
}
