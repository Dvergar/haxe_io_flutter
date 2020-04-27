import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Post extends StatelessWidget {
  final roundup;

  const Post({Key key, this.roundup}) : super(key: key);

  Future<String> getDocument(url) async {
    var client = Client();
    Response response = await client.get(url);
    var parsed = parse(response.body);

    return parsed.body.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "haxe.io",
            style: GoogleFonts.gentiumBookBasic(
                color: Color.fromARGB(255, 51, 51, 50), fontSize: 30),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
          future: getDocument(roundup['url']),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Container();
            return Markdown(
                data: snapshot.data,
                styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                    a: TextStyle(
                        color: Color.fromARGB(255, 29, 161, 242),
                        backgroundColor: Color.fromRGBO(29, 161, 242, 0.05))));
          },
        ));
  }
}
