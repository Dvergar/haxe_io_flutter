import 'package:flutter/material.dart';
import 'package:haxe_io_flutter/item.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'item_type.dart';
import 'widgets/my_chip.dart';
import 'widgets/post.dart';
import 'grid_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'haxe.io',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.red),
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: const Color(0xfffffdf9),
      ),
      home: const MyHomePage(title: 'haxe.io'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

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
              const SizedBox(width: 10),
              Text(
                widget.title,
                style: GoogleFonts.gentiumBookPlus(
                  color: const Color.fromARGB(255, 51, 51, 50),
                  fontSize: 30,
                ),
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
                List<Item> articles = snapshot.data;
                return GridView.count(
                  controller: _scrollController,
                  crossAxisCount: 2,
                  children: articles
                      .map(
                        (article) => GestureDetector(
                          onTap: () {
                            if (article.markdown) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Post(article: article),
                                ),
                              );
                            } else {
                              FlutterWebBrowser.openWebPage(
                                url: article.url,
                                customTabsOptions: const CustomTabsOptions(
                                  defaultColorSchemeParams:
                                      CustomTabsColorSchemeParams(
                                    toolbarColor: Colors.orangeAccent,
                                  ),
                                ),
                                // androidToolbarColor:
                                //     Colors.orangeAccent
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const HSLColor.fromAHSL(
                                          0.8, 47, 0.36, 0.95)
                                      .toColor(),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: const HSLColor.fromAHSL(
                                              0.3, 0, 0, 0.74)
                                          .toColor(),
                                      width: 1.0,
                                    ),
                                    right: BorderSide(
                                      color: const HSLColor.fromAHSL(
                                              0.3, 0, 0, 0.74)
                                          .toColor(),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        color:
                                            article.type.color.withOpacity(0.8),
                                        width: 4),
                                    Container(
                                        color:
                                            article.type.color.withOpacity(0.4),
                                        width: 4),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          article.label,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromARGB(
                                                255, 51, 51, 50),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
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

  const CustomAppBar({
    super.key,
    required this.onTap,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: appBar,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
