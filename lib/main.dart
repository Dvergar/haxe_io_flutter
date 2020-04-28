import 'package:flutter/material.dart';
import 'package:haxe_roundups_flutter/item_type.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'my_chip.dart';
import 'post.dart';
import 'grid_bloc.dart';

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
                MyChip(type: WeeklyNews()),
                MyChip(type: Articles()),
                MyChip(type: Releases()),
                MyChip(type: Events()),
                MyChip(type: LudumDare()),
                MyChip(type: DeveloperInterviews()),
                MyChip(type: Videos()),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                  stream: gridBloc.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return Container();
                    List<ItemType> articles = snapshot.data;
                    return GridView.count(
                        crossAxisCount: 2,
                        children: articles
                            .map((article) => GestureDetector(
                                  onTap: () {
                                    if (article.markdown) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Post(article: article)));
                                    } else {
                                      FlutterWebBrowser.openWebPage(
                                          url: article.url,
                                          androidToolbarColor:
                                              Colors.orangeAccent);
                                    }
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
