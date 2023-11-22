import 'dart:ui';

class ItemType {
  final Color color;
  // TODO rename
  final String typeLabel;

  ItemType({
    required this.color,
    required this.typeLabel,
  });
}

class WeeklyNews extends ItemType {
  WeeklyNews()
      : super(
          typeLabel: "Weekly News",
          color: Color.fromARGB(255, 241, 89, 34),
        );
}

class Releases extends ItemType {
  Releases()
      : super(
          typeLabel: "Releases",
          color: Color.fromARGB(255, 108, 198, 68),
        );
}

class Events extends ItemType {
  Events()
      : super(
          typeLabel: "Events",
          color: Color.fromARGB(255, 255, 128, 0),
        );
}

class Videos extends ItemType {
  Videos()
      : super(
          typeLabel: "Videos",
          color: Color.fromARGB(255, 205, 32, 31),
        );
}

class LudumDare extends ItemType {
  LudumDare()
      : super(
          typeLabel: "LudumDare",
          color: Color.fromARGB(255, 119, 68, 204),
        );
}

class DeveloperInterviews extends ItemType {
  DeveloperInterviews()
      : super(
          typeLabel: "Developer Interviews",
          color: Color.fromARGB(255, 255, 128, 0),
        );
}

class Articles extends ItemType {
  Articles()
      : super(
          typeLabel: "Articles",
          color: Color.fromARGB(255, 71, 99, 152),
        );
}
