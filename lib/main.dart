import 'package:flutter/material.dart';
import 'package:haxe_roundups_flutter/item_type.dart';

import 'package:html/dom.dart' as doom;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_chip.dart';
import 'post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haxe roundups',
      theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.red),
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 253, 249)),
      home: MyHomePage(title: 'haxe.io'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getDocument(url) async {
    var client = Client();
    Response response = await client.get(url);
    return parse(response.body);
  }

  Future<List<dynamic>> scrape() async {
    var document = await getDocument("https://haxe.io/");
    List<doom.Element> roundups =
        document.querySelectorAll('main > ul > li > a');

    getMarkDownLink(String href) {
      var hrefClean = href.substring(0, href.length - 1);
      return 'https://raw.githubusercontent.com/skial/haxe.io/master/src/$hrefClean.md';
    }

    return roundups.map((roundup) {
      // URL MANIPULATION
      var href = roundup.attributes['href'];
      var title = roundup.attributes['title'].replaceAll("â", "№");
      ItemType type;

      if (href.startsWith('/ld/')) {
        type = LudumDare(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/roundups/')) {
        type = WeeklyNews(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/releases/')) {
        type = Releases(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/wwx/')) // Fragile
      {
        type = DeveloperInterviews(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/videos/')) {
        type = Videos(title, getMarkDownLink(href), true);
      } else if (href.startsWith('/events/')) {
        type = Events(title, getMarkDownLink(href), true);
      } else if (roundup.parent.id == 'link--video') {
        type = Videos(title, href, false);
      } else if (roundup.parent.id == 'event--link') {
        type = Events(title, href, false);
      } else {
        type = Articles(title, href, false);
      }

      return type;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: GoogleFonts.gentiumBookBasic(
                color: Color.fromARGB(255, 51, 51, 50), fontSize: 30),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 18,
              children: <Widget>[
                MyChip(label: WeeklyNews().typeLabel, color: WeeklyNews().color),
                MyChip(label: Articles().typeLabel, color: Articles().color),
                MyChip(label: Releases().typeLabel, color: Releases().color),
                MyChip(label: Events().typeLabel, color: Events().color),
                MyChip(label: LudumDare().typeLabel, color: LudumDare().color),
                MyChip(
                    label: DeveloperInterviews().typeLabel,
                    color: DeveloperInterviews().color),
                MyChip(label: Videos().typeLabel, color: Videos().color),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: scrape(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return Container();
                    List<ItemType> articles = snapshot.data;
                    return GridView.count(
                        crossAxisCount: 2,
                        children: articles
                            .map((article) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Post(article: article)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            color:
                                                article.color.withOpacity(0.8),
                                            width: 4),
                                        Container(
                                            color:
                                                article.color.withOpacity(0.4),
                                            width: 4),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              article.label,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 50)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList());
                  }),
            ),
          ],
        ));
  }
}
