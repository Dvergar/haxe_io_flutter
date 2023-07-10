import 'package:flutter/material.dart';

enum ItemType {
  weeklyNews,
  releases,
  events,
  videos,
  developerInterviews,
  articles,
  ludumDare,
}

class ItemModel {
  final ItemType type;
  final String label;
  final String url;
  final bool markdown;
  final String? jsonUrl;

  ItemModel({
    required this.type,
    required this.label,
    required this.url,
    required this.markdown,
    this.jsonUrl,
  });
}

abstract class ItemView {
  late final ItemType type;
  late final Color color;
  late final String typeLabel;
}

class WeeklyNews implements ItemView {
  @override
  ItemType type = ItemType.weeklyNews;

  @override
  Color color = Color.fromARGB(255, 241, 89, 34);

  @override
  String typeLabel = "Weekly News";

  WeeklyNews();
}

class Releases extends ItemView {
  @override
  ItemType type = ItemType.releases;

  @override
  Color color = Color.fromARGB(255, 108, 198, 68);

  @override
  String typeLabel = "Releases";

  Releases();
}

class Events extends ItemView {
  @override
  ItemType type = ItemType.events;

  @override
  Color color = Color.fromARGB(255, 255, 128, 0);

  @override
  String typeLabel = "Events";

  Events();
}

class Videos extends ItemView {
  @override
  ItemType type = ItemType.videos;

  @override
  Color color = Color.fromARGB(255, 205, 32, 31);

  @override
  String typeLabel = "Videos";

  Videos();
}

class DeveloperInterviews extends ItemView {
  @override
  ItemType type = ItemType.developerInterviews;

  @override
  Color color = Color.fromARGB(255, 255, 128, 0);

  @override
  String typeLabel = "Developer Interviews";

  DeveloperInterviews();
}

class Articles extends ItemView {
  @override
  ItemType type = ItemType.articles;

  @override
  Color color = Color.fromARGB(255, 71, 99, 152);

  @override
  String typeLabel = "Articles";

  Articles();
}

class LudumDare extends ItemView {
  @override
  ItemType type = ItemType.ludumDare;

  @override
  Color color = Color.fromARGB(255, 119, 68, 204);

  @override
  String typeLabel = "LudumDare";

  LudumDare();
}
