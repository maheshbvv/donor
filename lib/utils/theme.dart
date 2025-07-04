import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: Color(0xfff1f1f1),
    primary: Color(0xffd7090f),
    secondary: Color(0xffFFFFFF),
    tertiary: Color(0xfff5f5f5),
  ),
  fontFamily: GoogleFonts.poppins().fontFamily,
);

final ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Color(0xff121212),
    primary: Color(0xffa11212),
    secondary: Color(0xffFFFFFF),
    tertiary: Color(0xfff5f5f5),
  ),
  fontFamily: GoogleFonts.poppins().fontFamily,
);
