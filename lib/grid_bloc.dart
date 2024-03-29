import 'dart:async';
import 'dart:convert';
import 'package:haxe_io_flutter/item.dart';
import 'package:html/dom.dart' as doom;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

import 'item_type.dart';

class GridBloc {
  List<Item> items = [];
  List<Type> filters = [];
  final gridController = StreamController<List<Item>>.broadcast();

  Stream get stream => gridController.stream;

  GridBloc() {
    scrape().then(
      (items) {
        this.items = items;
        gridController.sink.add(items);
      },
    );
  }

  Future<Document> getDocument(url) async {
    var client = Client();
    Response response = await client.get(Uri.parse(url));
    return parse(utf8.decode(response.bodyBytes));
  }

  Future<List<Item>> scrape() async {
    var document = await getDocument("https://haxe.io/");
    List<doom.Element> posts = document.querySelectorAll('main > ul > li > a');

    getMarkDownLink(String href) {
      var hrefClean = href.substring(0, href.length - 1);
      return 'https://raw.githubusercontent.com/skial/haxe.io/master/src/$hrefClean.md';
    }

    return posts.map((post) {
      // URL MANIPULATION
      var href = post.attributes['href']!;
      var title = post.attributes['title']!;
      Item type;

      if (href.startsWith('/ld/')) {
        String? jsonUrl;
        if (href == '/ld/36/') {
          jsonUrl =
              'https://raw.githubusercontent.com/skial/haxe.io/master/src/data/ld36.json';
        }
        if (href == '/ld/37/') {
          jsonUrl =
              'https://raw.githubusercontent.com/skial/haxe.io/master/src/data/ld37.json';
        }

        type = Item(
          type: LudumDare(),
          title: title,
          url: getMarkDownLink(href),
          markdown: true,
          jsonUrl: jsonUrl,
        );
      } else if (href.startsWith('/roundups/')) {
        type = Item(
          type: WeeklyNews(),
          title: title,
          url: getMarkDownLink(href),
          markdown: true,
        );
      } else if (href.startsWith('/releases/')) {
        type = Item(
          type: Releases(),
          title: title,
          url: getMarkDownLink(href),
          markdown: true,
        );
      } else if (href.startsWith('/wwx/')) // Fragile
      {
        var mdLink = getMarkDownLink(href);
        mdLink = mdLink.replaceAll("-", " ");
        type = Item(
          type: DeveloperInterviews(),
          title: title,
          url: mdLink,
          markdown: true,
        );
      } else if (href.startsWith('/videos/')) {
        type = Item(
          type: Videos(),
          title: title,
          url: getMarkDownLink(href),
          markdown: true,
        );
      } else if (href.startsWith('/events/')) {
        type = Item(
          type: Events(),
          title: title,
          url: getMarkDownLink(href),
          markdown: true,
        );
      } else if (post.parent?.id == 'link--video') {
        type = Item(
          type: Videos(),
          title: title,
          url: href,
          markdown: false,
        );
      } else if (post.parent?.id == 'event--link') {
        type = Item(
          type: Events(),
          title: title,
          url: href,
          markdown: false,
        );
      } else {
        type = Item(
          type: Articles(),
          title: title,
          url: href,
          markdown: false,
        );
      }

      return type;
    }).toList();
  }

  sortBy(ItemType itemType) {
    // ADD/REMOVE FILTERS
    if (!filters.contains(itemType.runtimeType)) {
      filters.add(itemType.runtimeType);
    } else {
      filters.remove(itemType.runtimeType);
    }

    // ALL ITEMS
    if (filters.isEmpty) {
      gridController.sink.add(items);
      return;
    }

    // DO FILTER
    var filteredItems =
        items.where((item) => filters.contains(item.type.runtimeType)).toList();

    gridController.sink.add(filteredItems);
  }

  void dispose() {
    gridController.close();
  }
}

final gridBloc = GridBloc();
