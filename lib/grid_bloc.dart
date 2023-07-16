import 'dart:async';
import 'dart:convert';
import 'package:haxe_io_flutter/item_type.dart';
import 'package:html/dom.dart' as doom;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class GridBloc {
  List<ItemModel> items = [];
  List<ItemType> filters = [];
  final gridController = StreamController.broadcast();

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

  Future<List<ItemModel>> scrape() async {
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
      ItemModel type;

      // TODO make it dynamic
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

        type = ItemModel(
          label: title,
          url: getMarkDownLink(href),
          markdown: true,
          jsonUrl: jsonUrl,
          type: ItemType.ludumDare,
        );
      } else if (href.startsWith('/roundups/')) {
        type = ItemModel(
          label: title,
          url: getMarkDownLink(href),
          markdown: true,
          type: ItemType.weeklyNews,
        );
      } else if (href.startsWith('/releases/')) {
        type = ItemModel(
          label: title,
          url: getMarkDownLink(href),
          markdown: true,
          type: ItemType.releases,
        );
      } else if (href.startsWith('/wwx/')) // Fragile
      {
        var mdLink = getMarkDownLink(href);
        mdLink = mdLink.replaceAll("-", " ");
        type = ItemModel(
          label: title,
          url: mdLink,
          markdown: true,
          type: ItemType.developerInterviews,
        );
      } else if (href.startsWith('/videos/')) {
        type = ItemModel(
          label: title,
          url: getMarkDownLink(href),
          markdown: true,
          type: ItemType.videos,
        );
      } else if (href.startsWith('/events/')) {
        type = ItemModel(
          label: title,
          url: getMarkDownLink(href),
          markdown: true,
          type: ItemType.events,
        );
      } else if (post.parent?.id == 'link--video') {
        type = ItemModel(
          label: title,
          url: href,
          markdown: false,
          type: ItemType.videos,
        );
      } else if (post.parent?.id == 'event--link') {
        type = ItemModel(
          label: title,
          url: href,
          markdown: false,
          type: ItemType.events,
        );
      } else {
        type = ItemModel(
          label: title,
          url: href,
          markdown: false,
          type: ItemType.articles,
        );
      }

      return type;
    }).toList();
  }

  sortBy(ItemType type) {
    // ADD/REMOVE FILTERS
    if (!filters.contains(type)) {
      filters.add(type);
    } else {
      filters.remove(type);
    }

    // ALL ITEMS
    if (filters.isEmpty) {
      gridController.sink.add(items);
      return;
    }

    // DO FILTER
    var filteredItems =
        items.where((item) => filters.contains(item.type)).toList();
    gridController.sink.add(filteredItems);
  }

  void dispose() {
    gridController.close();
  }
}

final gridBloc = GridBloc();
