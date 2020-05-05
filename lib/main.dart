import 'package:flutter/material.dart';
import 'package:haxe_io_flutter/item_type.dart';

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
      title: 'haxe.io',
      theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.red),
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Color(0xfffffdf9)),
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
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/icon.png", height: 30),
              SizedBox(width: 10),
              Text(
                widget.title,
                style: GoogleFonts.gentiumBookBasic(
                    color: Color.fromARGB(255, 51, 51, 50), fontSize: 30),
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        onTap: () {
          _scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 15,
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
          ),
          Expanded(
            child: StreamBuilder(
                stream: gridBloc.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return Container();
                  List<ItemType> articles = snapshot.data;
                  return GridView.count(
                      controller: _scrollController,
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HSLColor.fromAHSL(
                                                0.8, 47, 0.36, 0.95)
                                            .toColor(),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: HSLColor.fromAHSL(
                                                    0.3, 0, 0, 0.74)
                                                .toColor(),
                                            width: 1.0,
                                          ),
                                          right: BorderSide(
                                            color: HSLColor.fromAHSL(
                                                    0.3, 0, 0, 0.74)
                                                .toColor(),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              color: article.color
                                                  .withOpacity(0.8),
                                              width: 4),
                                          Container(
                                              color: article.color
                                                  .withOpacity(0.4),
                                              width: 4),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                article.label,
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
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
                                  ),
                                ),
                              ))
                          .toList());
                }),
          ),
        ],
      ),
    );
  }
}

// Custom appbar to add onTap
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  const CustomAppBar({Key key, this.onTap, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: appBar);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
