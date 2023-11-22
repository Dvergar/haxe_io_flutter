import 'package:flutter/material.dart';

import 'package:haxe_io_flutter/widgets/articles.dart';
import 'package:haxe_io_flutter/widgets/header.dart';

import 'item_type.dart';
import 'widgets/my_chip.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
          title: const Header(),
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
            child: ArticlesWidget(_scrollController),
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
