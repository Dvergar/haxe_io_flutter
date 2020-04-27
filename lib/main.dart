import 'package:flutter/material.dart';

import 'package:html/dom.dart' as doom;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';

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

    // for (var roundup in roundups) print(roundup.attributes['title']);

    return roundups
        .map((roundup) => {
              'title': roundup.attributes['title']
                  .replaceAll("â", "№"), // Skipping encoding battles :3
              'url': roundup.attributes['href']
            })
        .toList();
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
        body: FutureBuilder(
            future: scrape(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return Container();
              List<dynamic> roundups = snapshot.data;
              return GridView.count(
                  crossAxisCount: 2,
                  children: roundups
                      .map((roundup) => GestureDetector(
                            onTap: () {
                              print("hello");
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
                                      color: Color.fromRGBO(241, 89, 34, 0.8),
                                      width: 4),
                                  Container(
                                      color: Color.fromRGBO(241, 89, 34, 0.4),
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
            }));
  }
}
