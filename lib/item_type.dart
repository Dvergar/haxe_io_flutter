import 'dart:ui';

class ItemType {
  final Color color;
  final String label;

  ItemType({
    required this.color,
    required this.label,
  });
}

class WeeklyNews extends ItemType {
  WeeklyNews()
      : super(
          label: "Weekly News",
          color: const Color.fromARGB(255, 241, 89, 34),
        );
}

class Releases extends ItemType {
  Releases()
      : super(
          label: "Releases",
          color: const Color.fromARGB(255, 108, 198, 68),
        );
}

class Events extends ItemType {
  Events()
      : super(
          label: "Events",
          color: const Color.fromARGB(255, 255, 128, 0),
        );
}

class Videos extends ItemType {
  Videos()
      : super(
          label: "Videos",
          color: const Color.fromARGB(255, 205, 32, 31),
        );
}

class LudumDare extends ItemType {
  LudumDare()
      : super(
          label: "LudumDare",
          color: const Color.fromARGB(255, 119, 68, 204),
        );
}

class DeveloperInterviews extends ItemType {
  DeveloperInterviews()
      : super(
          label: "Developer Interviews",
          color: const Color.fromARGB(255, 255, 128, 0),
        );
}

class Articles extends ItemType {
  Articles()
      : super(
          label: "Articles",
          color: const Color.fromARGB(255, 71, 99, 152),
        );
}
