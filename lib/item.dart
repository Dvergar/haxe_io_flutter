import 'package:haxe_io_flutter/item_type.dart';

class Item {
  final ItemType type;
  final String label;
  final String url;
  final String? jsonUrl;
  final bool markdown;

  Item({
    required this.type,
    required this.label,
    required this.url,
    required this.jsonUrl,
    required this.markdown,
  });
}
