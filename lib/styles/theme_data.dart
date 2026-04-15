import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: GoogleFonts.dmSansTextTheme(),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.dmSansTextTheme(
    ThemeData.dark().textTheme,
  ),
);