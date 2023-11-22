import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haxe_io_flutter/grid_bloc.dart';
import 'package:haxe_io_flutter/item.dart';
import 'package:haxe_io_flutter/widgets/post.dart';

class ArticlesWidget extends StatelessWidget {
  final ScrollController _scrollController;

  const ArticlesWidget(this._scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                          defaultColorSchemeParams: CustomTabsColorSchemeParams(
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
                          color: const HSLColor.fromAHSL(0.8, 47, 0.36, 0.95)
                              .toColor(),
                          border: Border(
                            bottom: BorderSide(
                              color: const HSLColor.fromAHSL(0.3, 0, 0, 0.74)
                                  .toColor(),
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: const HSLColor.fromAHSL(0.3, 0, 0, 0.74)
                                  .toColor(),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                                color: article.type.color.withOpacity(0.8),
                                width: 4),
                            Container(
                                color: article.type.color.withOpacity(0.4),
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
                                    color:
                                        const Color.fromARGB(255, 51, 51, 50),
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
    );
  }
}
