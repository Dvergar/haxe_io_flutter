import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haxe_io_flutter/stylesheet.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:flutter/gestures.dart';

import 'item.dart';
import 'dart:convert';

var ldJson = '''
{
  "ld": 37,
  "entries": [
    {
      "author": {
        "name": "bendmorris",
        "url": "/author/bendmorris/"
      },
      "frameworks": [
        "HaxePunk",
        "Haxe"
      ],
      "links": [
        {
          "label": "web (html5/webgl)",
          "url": "http://www.bendmorris.com/static/whathaveidone/index.html"
        },
        {
          "label": "source",
          "url": "https://github.com/bendmorris/ld37"
        }
      ],
      "name": "What Have I Done? A Virtual Pet Simulator",
      "platforms": [
        "web",
        "html5",
        "source",
        "github"
      ],
      "type": "compo",
      "url": "?action=preview&uid=36156"
    },
    {
      "author": {
        "name": "MichaelPelgonen",
        "url": "/author/michaelpelgonen/"
      },
      "frameworks": [
        "OpenFL",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "https://www.dropbox.com/s/5hbu0xuy8fcck27/LD37.swf?dl=1"
        }
      ],
      "name": "Refuge",
      "platforms": [
        "web"
      ],
      "type": "compo",
      "url": "?action=preview&uid=37518"
    },
    {
      "author": {
        "name": "Jonathan50",
        "url": "/author/jonathan50/"
      },
      "frameworks": [
        "OpenFL",
        "Haxe"
      ],
      "links": [
        {
          "label": "html5 (slow on my old pc, ui bad for mobile)",
          "url": "https://jonathan50.github.io/room-designer/v1.0.0/index.html"
        },
        {
          "label": "flash (text formatted wrong)",
          "url": "https://jonathan50.github.io/room-designer/v1.0.0/room-designer.swf"
        },
        {
          "label": "gnu/linux x86-64 (recommended)",
          "url": "https://github.com/Jonathan50/room-designer/releases/download/v1.0.0/room-designer-gnu-linux-x86-64.zip"
        },
        {
          "label": "android (recommended)",
          "url": "https://github.com/Jonathan50/room-designer/releases/download/v1.0.0/room-designer.apk"
        },
        {
          "label": "source",
          "url": "https://github.com/Jonathan50/room-designer/archive/v1.0.0.zip"
        }
      ],
      "name": "Room Designer",
      "platforms": [
        "html5",
        "github",
        "flash",
        "android",
        "source"
      ],
      "type": "jam",
      "url": "?action=preview&uid=125171"
    },
    {
      "author": {
        "name": "aeveis",
        "url": "/author/aeveis/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "https://aeveis.itch.io/dragon-defroster"
        },
        {
          "label": "source",
          "url": "https://dl.dropboxusercontent.com/u/16325832/ludum_dare37/ludum_dare37.zip"
        }
      ],
      "name": "Dragon Defroster",
      "platforms": [
        "web",
        "itch.io",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=8854"
    },
    {
      "author": {
        "name": "ziege",
        "url": "/author/ziege/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "https://ziege.itch.io/gentlemans-darling"
        },
        {
          "label": "linux",
          "url": "https://ziege.itch.io/gentlemans-darling"
        },
        {
          "label": "source",
          "url": "https://ziege.itch.io/gentlemans-darling"
        }
      ],
      "name": "Gentleman's Darling",
      "platforms": [
        "web",
        "itch.io",
        "linux",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=24822"
    },
    {
      "author": {
        "name": "lukethecoder64",
        "url": "/author/lukethecoder64/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://lukethecoder64.github.io/LD37/"
        }
      ],
      "name": "Mini Dungeon",
      "platforms": [
        "web",
        "github"
      ],
      "type": "jam",
      "url": "?action=preview&uid=49696"
    },
    {
      "author": {
        "name": "Sébastien Bernery",
        "url": ""
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://docs.bernery.eu/gamejam/PotatoPanicRoom/html5"
        },
        {
          "label": "web (flash)",
          "url": "http://docs.bernery.eu/gamejam/PotatoPanicRoom/"
        },
        {
          "label": "source",
          "url": "http://docs.bernery.eu/gamejam/PotatoPanicRoom/potato_panic_room_src.tar.xz"
        }
      ],
      "name": "Potato Panic Room",
      "platforms": [
        "web",
        "html5",
        "flash",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=484"
    },
    {
      "author": {
        "name": "Ithildin",
        "url": "/author/ithildin/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://ithildin.itch.io/ld37"
        },
        {
          "label": "windows",
          "url": "https://dl.dropboxusercontent.com/u/8967322/ld37/roachescape_win.zip"
        },
        {
          "label": "lv. 1 gameplay",
          "url": "https://www.youtube.com/watch?v=i7K4-X-WIJQ"
        },
        {
          "label": "post-mortem",
          "url": "http://ludumdare.com/compo/2016/12/18/post-mortem-roach-escape/"
        },
        {
          "label": "source",
          "url": "https://github.com/wildrabbit/ld37"
        }
      ],
      "name": "Roach Escape",
      "platforms": [
        "web",
        "itch.io",
        "windows",
        "source",
        "github"
      ],
      "type": "compo",
      "url": "?action=preview&uid=15664"
    },
    {
      "author": {
        "name": "cxsquared",
        "url": "/author/cxsquared/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web (flash)",
          "url": "http://gamejolt.com/games/the-chores/217720"
        },
        {
          "label": "web (html5)",
          "url": "http://codyclaborn.me/games/LD37/"
        },
        {
          "label": "source",
          "url": "https://github.com/cxsquared/LD37"
        },
        {
          "label": "music",
          "url": "https://soundcloud.com/cxsquared/one-room"
        }
      ],
      "name": "The Chore",
      "platforms": [
        "web",
        "flash",
        "html5",
        "source",
        "github"
      ],
      "type": "jam",
      "url": "?action=preview&uid=23711"
    },
    {
      "author": {
        "name": "Zener",
        "url": "/author/zener/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://zener.kung-foo.net/ld37/index.html"
        },
        {
          "label": "source",
          "url": "http://zener.kung-foo.net/ld37/LudumDare37_src.zip"
        }
      ],
      "name": "The Oval Office",
      "platforms": [
        "web",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=12819"
    },
    {
      "author": {
        "name": "SoKette",
        "url": "/author/sokette/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web (html5, requires keyboard)",
          "url": "http://sokette.info/game/VRplaySim.html"
        },
        {
          "label": "windows (+ tested on wine)",
          "url": "https://drive.google.com/open?id=0B3yBSzCkgJrgQmR4X2MteGl2Z3c"
        },
        {
          "label": "source",
          "url": "https://drive.google.com/open?id=0B3yBSzCkgJrgdDlhMmE3U0U0Z0k"
        }
      ],
      "name": "VR Player Simulator",
      "platforms": [
        "web",
        "html5",
        "windows",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=113882"
    },
    {
      "author": {
        "name": "01010111",
        "url": "/author/01010111/"
      },
      "frameworks": [
        "HaxeFlixel",
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "https://01010111.itch.io/spring-cleaning"
        },
        {
          "label": "source",
          "url": "https://github.com/01010111/spring_cleaning"
        }
      ],
      "name": "spring cleaning",
      "platforms": [
        "web",
        "itch.io",
        "source",
        "github"
      ],
      "type": "compo",
      "url": "?action=preview&uid=11474"
    },
    {
      "author": {
        "name": "regisclaus",
        "url": "/author/regisclaus/"
      },
      "frameworks": [
        "Stencyl"
      ],
      "links": [
        {
          "label": "web",
          "url": "https://regisclaus.itch.io/abstract-room"
        },
        {
          "label": "source",
          "url": "https://dl.dropboxusercontent.com/u/1239083/LudumDare37.stencyl"
        }
      ],
      "name": "Abstract Room",
      "platforms": [
        "web",
        "itch.io",
        "source"
      ],
      "type": "jam",
      "url": "?action=preview&uid=14260"
    },
    {
      "author": {
        "name": "ceosol",
        "url": "/author/ceosol/"
      },
      "frameworks": [
        "Stencyl"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://gamejolt.com/games/cold-day-in-the-office/217300"
        },
        {
          "label": "stencylarcade",
          "url": "http://www.stencyl.com/game/play/35688"
        },
        {
          "label": "source",
          "url": "http://gamejolt.com/games/cold-day-in-the-office/217300"
        }
      ],
      "name": "Cold Day in the Office",
      "platforms": [
        "web",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=34411"
    },
    {
      "author": {
        "name": "Pantelis Petsopoulos",
        "url": "/author/vururia/"
      },
      "frameworks": [
        "Stencyl"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://www.stencyl.com/game/play/35692"
        },
        {
          "label": "source",
          "url": "https://www.dropbox.com/s/m17gt4enkyf6d3u/El%20Laberinto%20De%20Pereira.stencyl?dl=0"
        }
      ],
      "name": "El Laberinto De Pereira",
      "platforms": [
        "web",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=34259"
    },
    {
      "author": {
        "name": "AtomFox0213",
        "url": "/author/atomfox0213/"
      },
      "frameworks": [
        "Stencyl"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://www.newgrounds.com/portal/view/685712"
        }
      ],
      "name": "Escape The Room",
      "platforms": [
        "web"
      ],
      "type": "jam",
      "url": "?action=preview&uid=57550"
    },
    {
      "author": {
        "name": "xWarZonex",
        "url": "/author/xwarzonex/"
      },
      "frameworks": [
        "Stencyl"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://www.stencyl.com/game/play/35696"
        },
        {
          "label": "windows",
          "url": "https://dl.dropboxusercontent.com/u/275699050/LD%2037.swf"
        },
        {
          "label": "source",
          "url": "https://dl.dropboxusercontent.com/u/275699050/Source.stencyl"
        }
      ],
      "name": "Masquerade",
      "platforms": [
        "web",
        "windows",
        "source"
      ],
      "type": "compo",
      "url": "?action=preview&uid=39237"
    },
    {
      "author": {
        "name": "alexmakovsky",
        "url": "/author/alexmakovsky/"
      },
      "frameworks": [
        "Stencyl"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://brosnarium.deviantart.com/art/Unfinished-Shaman-Game-Demo-for-LudumDare-650938223"
        }
      ],
      "name": "Unfinished Shaman Game Demo",
      "platforms": [
        "web"
      ],
      "type": "jam",
      "url": "?action=preview&uid=124680"
    },
    {
      "author": {
        "name": "Valandre",
        "url": "/author/valandre/"
      },
      "frameworks": [
        "Haxe"
      ],
      "links": [
        {
          "label": "play [web]",
          "url": "http://retrofusion.fr/LD37/index.html"
        },
        {
          "label": "source",
          "url": "http://retrofusion.fr/LD37/LD37.rar"
        }
      ],
      "name": "FairyTrail",
      "platforms": [
        "source"
      ],
      "type": "jam",
      "url": "?action=preview&uid=3211"
    },
    {
      "author": {
        "name": "qFrct",
        "url": "/author/qfrct/"
      },
      "frameworks": [
        "Haxe"
      ],
      "links": [
        {
          "label": "web dl postjam version",
          "url": "http://dl.free.fr/ilvq8lnsi"
        },
        {
          "label": "web dl jamversion",
          "url": "http://dl.free.fr/mDbrIMNTm"
        },
        {
          "label": "web jamversion",
          "url": "https://itch.io/embed-upload/343469?color=333333"
        }
      ],
      "name": "MiniVampires",
      "platforms": [
        "web",
        "itch.io"
      ],
      "type": "jam",
      "url": "?action=preview&uid=44664"
    },
    {
      "author": {
        "name": "Aurel Bílý",
        "url": ""
      },
      "frameworks": [
        "Haxe"
      ],
      "links": [
        {
          "label": "web (flash)",
          "url": "http://ludum.thenet.sk/ld37/"
        },
        {
          "label": "web (javascript port)",
          "url": "http://ludum.thenet.sk/ld37/?js"
        },
        {
          "label": "source (haxe)",
          "url": "http://ludum.thenet.sk/ld37/onerooms_src.zip"
        },
        {
          "label": "post-mortem",
          "url": "http://thenet.sk/?game/0014"
        },
        {
          "label": "timelapse",
          "url": "https://www.youtube.com/watch?v=f5kM8yqQQpI"
        }
      ],
      "name": "one rooms",
      "platforms": [
        "web",
        "flash",
        "source"
      ],
      "type": "jam",
      "url": "?action=preview&uid=1645"
    },
    {
      "author": {
        "name": "liglet_g",
        "url": "/author/liglet_g/"
      },
      "frameworks": [
        "Haxe"
      ],
      "links": [
        {
          "label": "web",
          "url": "http://ld37.gregoire-liglet.com/ld37/html5/"
        },
        {
          "label": "source",
          "url": "https://www.dropbox.com/s/u6to3ofnbbrrb6a/ld37-src.zip?dl=0"
        },
        {
          "label": "os/x",
          "url": "https://www.dropbox.com/s/8mu7u438fyuycy6/ld37-macos.zip?dl=0"
        },
        {
          "label": "html5",
          "url": "https://www.dropbox.com/s/wd8smsxupabvsqe/ld37-html5.zip?dl=0"
        },
        {
          "label": "github",
          "url": "https://github.com/ligletg/ld37"
        }
      ],
      "name": "The Small Escape",
      "platforms": [
        "web",
        "html5",
        "source",
        "osx",
        "github"
      ],
      "type": "compo",
      "url": "?action=preview&uid=124084"
    }
  ],
  "frameworks": [
    {
      "framework": "Haxe"
    },
    {
      "framework": "OpenFL"
    },
    {
      "framework": "HaxeFlixel"
    },
    {
      "framework": "HaxePunk"
    },
    {
      "framework": "Stencyl"
    }
  ]
}
''';

class Post extends StatefulWidget {
  final Item article;

  const Post({super.key, required this.article});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  Future<String> getDocument(url) async {
    var client = Client();
    Response response = await client.get(Uri.parse(url));
    var parsed = parse(response.body);

    return parsed.body!.text;
  }

  List<Widget> parseJson(String data) {
    List<Widget> widgets = [];

    print("DATA $data");

    Map<dynamic, dynamic> decodedJson = json.decode(data);

    for (var framework in decodedJson['frameworks']) {
      String frameworkName = framework['framework'];
      List<dynamic> entries = decodedJson['entries'];

      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(frameworkName,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xff333332))),
      ));

      var games = entries.where((entry) {
        var frameworks = entry['frameworks'];

        return frameworks.contains(frameworkName);
      }).toList();

      for (var game in games) {
        if (frameworkName == 'Haxe' && game['frameworks'].length > 1) {
          continue;
        }

        var gameType =
            '${game['type'][0].toUpperCase()}${game['type'].substring(1)}';
        var typeColor = jamColor;
        if (gameType == 'Compo') typeColor = compoColor;

        widgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: pFontSize, color: Colors.black),
                    children: <TextSpan>[
                      const TextSpan(
                          text: "    ⬤    ",
                          style: TextStyle(
                              fontSize: 10, color: Color(0xff333332))),
                      TextSpan(
                          text: game['name'],
                          style: const TextStyle(
                              color: aColor, backgroundColor: aBackgroundColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => FlutterWebBrowser.openWebPage(
                                url:
                                    "http://ludumdare.com/compo/ludum-dare-37/${game['url']}",
                                customTabsOptions: const CustomTabsOptions(
                                    toolbarColor: Colors.orangeAccent)
                                // androidToolbarColor: Colors.orangeAccent
                                )),
                      const TextSpan(text: ' by '),
                      TextSpan(
                          text: game['author']['name'],
                          style: const TextStyle(
                              color: aColor, backgroundColor: aBackgroundColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => FlutterWebBrowser.openWebPage(
                                url:
                                    "http://ludumdare.com/compo${game['author']['url']}",
                                customTabsOptions: const CustomTabsOptions(
                                    toolbarColor: Colors.orangeAccent)
                                // androidToolbarColor: Colors.orangeAccent
                                )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: Text(
                      gameType,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: typeColor),
                    )),
              )
            ],
          ),
        );
      }
    }

    return widgets;
  }

  Future<String> getMarkdown(url) async {
    var markdown = await getDocument(url);
    // REPLACE WEIRD TOP CHARACTERS
    markdown = markdown.replaceAll('[“”]: a ""', ''); // What is this ?
    // MUTATE RELATIVE TO ABSOLUTE LINKS
    markdown = markdown.replaceAll('/img/',
        'https://raw.githubusercontent.com/skial/haxe.io/master/src/img/');
    // TRANSFORM IFRAMES TO LINKS
    markdown =
        markdown.replaceAllMapped(RegExp(r'!\[iframe\]\((.*)\)'), (match) {
      return '${match.group(1)}';
    });
    return markdown;
  }

  Future<List<Widget>> getJson(url) async {
    return parseJson(await getDocument(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.article.type.typeLabel,
            style: GoogleFonts.gentiumBookPlus(
                color: const Color.fromARGB(255, 51, 51, 50), fontSize: 30),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: getMarkdown(widget.article.url),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const SpinKitChasingDots(
                      color: Colors.orangeAccent,
                      size: 100.0,
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MarkdownBody(
                      shrinkWrap: true,
                      data: snapshot.data,
                      styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(
                              fontSize: pFontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                          a: const TextStyle(
                              color: aColor,
                              backgroundColor: aBackgroundColor)),
                      onTapLink: (text, link, title) {
                        print("link $link");
                        FlutterWebBrowser.openWebPage(
                          url: link!,
                          // androidToolbarColor: Colors.orangeAccent
                          customTabsOptions: const CustomTabsOptions(
                            toolbarColor: Colors.orangeAccent,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              widget.article.jsonUrl != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<List<Widget>>(
                          future: getJson(widget.article.jsonUrl),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SpinKitChasingDots(
                                color: Colors.orangeAccent,
                                size: 100.0,
                              );
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ...snapshot.data!,
                              ],
                            );
                          }),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
