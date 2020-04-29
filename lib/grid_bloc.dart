import 'dart:async';
import 'package:haxe_io_flutter/item_type.dart';
import 'package:html/dom.dart' as doom;
import 'package:html/parser.dart';
import 'package:http/http.dart';

class GridBloc {
  List<ItemType> items = [];
  List<Type> filters = [];
  final gridController = StreamController.broadcast();

  Stream get stream => gridController.stream;

  GridBloc() {
    scrape().then((items) {
      this.items = items;
      gridController.sink.add(items);
    });
  }

  Future getDocument(url) async {
    var client = Client();
    Response response = await client.get(url);
    return parse(response.body);
  }

  Future<List<dynamic>> scrape() async {
    var document = await getDocument("https://haxe.io/");
    List<doom.Element> posts =
        document.querySelectorAll('main > ul > li > a');

    getMarkDownLink(String href) {
      var hrefClean = href.substring(0, href.length - 1);
      return 'https://raw.githubusercontent.com/skial/haxe.io/master/src/$hrefClean.md';
    }

    return posts.map((post) {
      // URL MANIPULATION
      var href = post.attributes['href'];
      var title = post.attributes['title'].replaceAll("â", "№");
      ItemType type;

      if (href.startsWith('/ld/')) {
        type = LudumDare(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/roundups/')) {
        type = WeeklyNews(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/releases/')) {
        type = Releases(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/wwx/')) // Fragile
      {
        var mdLink = getMarkDownLink(href);
        mdLink = mdLink.replaceAll("-", " ");
        type = DeveloperInterviews(title, mdLink, true);
      } else if (href.startsWith('/videos/')) {
        type = Videos(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/events/')) {
        type = Events(title, getMarkDownLink(href), true);
      } else if (post.parent.id == 'link--video') {
        type = Videos(title, href, false);
      } else if (post.parent.id == 'event--link') {
        type = Events(title, href, false);
      } else {
        type = Articles(title, href, false);
      }

      return type;
    }).toList();
  }

  sortBy(ItemType chip) {
    if (!filters.contains(chip.runtimeType)) {
      filters.add(chip.runtimeType);
    } else {
      filters.remove(chip.runtimeType);
    }

    var filteredItems =
        this.items.where((item) => filters.contains(item.runtimeType)).toList();
    gridController.sink.add(filteredItems);
    print("sortby");
  }

  void dispose() {
    gridController.close();
  }
}

final gridBloc = GridBloc();
