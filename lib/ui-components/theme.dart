import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class CustomColorSwatch {
  static const MaterialColor pimary =
      MaterialColor(_pimaryPrimaryValue, <int, Color>{
    50: Color(0xFFE4E4E4),
    100: Color(0xFFD6E9FF),
    200: Color(0xFFB8D9FF),
    300: Color(0xFF97C8FF),
    400: Color(0xFF7CBAFF),
    500: Color(_pimaryPrimaryValue),
    600: Color(0xFF3A97FE),
    700: Color(0xFF1A81F4),
    800: Color(0xFF006EE9),
    900: Color(0xFF105CDB),
  });
  static const int _pimaryPrimaryValue = 0xFF006EE9;

  static const MaterialColor pimaryAccent =
      MaterialColor(_pimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_pimaryAccentValue),
    400: Color(0xFF9BB1FF),
    700: Color(0xFF819DFF),
  });
  static const int _pimaryAccentValue = 0xFF9A9A9A;
  static const subheadingColor = Color(0xFF474747);
}

class CustomThemeData {
  static final themeData = ThemeData(
    primarySwatch: CustomColorSwatch.pimary,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}
