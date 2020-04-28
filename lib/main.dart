import 'package:flutter/material.dart';

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

    return roundups.map((roundup) {
      var href = roundup.attributes['href'];
      var hrefClean = href.substring(0, href.length - 1);

      return {
        'title': roundup.attributes['title']
            .replaceAll("â", "№"), // Skipping encoding battles :3
        'url':
            'https://raw.githubusercontent.com/skial/haxe.io/master/src/$hrefClean.md'
      };
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
                MyChip(label: "Weekly News", color: Color.fromARGB(255, 241, 89, 34)),
                MyChip(label: "Articles", color: Color.fromARGB(255, 71, 99, 152)),
                MyChip(label: "Releases", color: Color.fromARGB(255, 108, 198, 68)),
                MyChip(label: "Events", color: Color.fromARGB(255, 255, 128, 0)),
                MyChip(label: "Ludum Dare", color: Color.fromARGB(255, 119, 68, 204)),
                MyChip(label: "Developer Interviews", color: Color.fromARGB(255, 255, 128, 0)),
                MyChip(label: "Videos", color: Color.fromARGB(255, 205, 32, 31)),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: scrape(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return Container();
                    List<dynamic> roundups = snapshot.data;
                    return GridView.count(
                        // shrinkWrap: true,
                        crossAxisCount: 2,
                        children: roundups
                            .map((roundup) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Post(roundup: roundup)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            color: Color.fromRGBO(
                                                241, 89, 34, 0.8),
                                            width: 4),
                                        Container(
                                            color: Color.fromRGBO(
                                                241, 89, 34, 0.4),
                                            width: 4),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              roundup['title'],
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
