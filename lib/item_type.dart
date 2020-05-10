import 'package:flutter/material.dart';

abstract class ItemType {
  Color color;
  String typeLabel;
  String label;
  String url;
  String jsonUrl;
  bool markdown;

  ItemType([this.label, this.url, this.markdown, this.jsonUrl]);
}

class WeeklyNews extends ItemType {
  var typeLabel = "Weekly News";
  var color = Color.fromARGB(255, 241, 89, 34);

  WeeklyNews([String label, String url, bool markdown])
      : super(label, url, markdown);
}

class Releases extends ItemType {
  var typeLabel = "Releases";
  var color = Color.fromARGB(255, 108, 198, 68);

  Releases([String label, String url, bool markdown])
      : super(label, url, markdown);
}

class Events extends ItemType {
  var typeLabel = "Events";
  var color = Color.fromARGB(255, 255, 128, 0);

  Events([String label, String url, bool markdown])
      : super(label, url, markdown);
}

class Videos extends ItemType {
  var typeLabel = "Videos";
  var color = Color.fromARGB(255, 205, 32, 31);

  Videos([String label, String url, bool markdown])
      : super(label, url, markdown);
}

class LudumDare extends ItemType {
  var typeLabel = "LudumDare";
  var color = Color.fromARGB(255, 119, 68, 204);

  LudumDare([String label, String url, bool markdown, String jsonUrl])
      : super(label, url, markdown, jsonUrl);
}

class DeveloperInterviews extends ItemType {
  var typeLabel = "Developer Interviews";
  var color = Color.fromARGB(255, 255, 128, 0);

  DeveloperInterviews([String label, String url, bool markdown])
      : super(label, url, markdown);
}

class Articles extends ItemType {
  var typeLabel = "Articles";
  var color = Color.fromARGB(255, 71, 99, 152);

  Articles([String label, String url, bool markdown])
      : super(label, url, markdown);
}
