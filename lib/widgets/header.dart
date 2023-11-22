import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/icon.png", height: 30),
        const SizedBox(width: 10),
        Text(
          'haxe.io',
          style: GoogleFonts.gentiumBookPlus(
            color: const Color.fromARGB(255, 51, 51, 50),
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
