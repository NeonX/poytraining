import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyle {
  Color txtColor = Colors.red.shade900;
  Color mainColor = Color.fromARGB(0xff, 0x74, 0x74, 0x74);
  Color barColor = Color.fromARGB(0xff, 0x74, 0x74, 0x74);

  TextStyle h1Main = GoogleFonts.exo2(
      textStyle: TextStyle(
          fontSize: 20,
          color: Colors.red.shade900,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic));

  MyStyle();
}
