import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static TextStyle regular = TextStyle(fontFamily: 'Montserrat', fontSize: 16);
  static TextStyle bold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static TextStyle black = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );
}

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: Color(0xFF00A3E0),
    secondary: Color(0xFF4169E1),
    inverseSurface: Colors.white,
  ),
);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Color(0xFF4169E1),
    secondary: Color(0xFF00A3E0),
    inverseSurface: Colors.black,
  ),
);

class ThemeProvider {
  static final ValueNotifier<ThemeData> themeNotifier = ValueNotifier(darkMode);

  static void toggleTheme() {
    themeNotifier.value = themeNotifier.value == darkMode
        ? lightMode
        : darkMode;
  }
}
