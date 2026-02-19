import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static final TextStyle regular = TextStyle(
    fontFamily: "Poppins",
    fontSize: 16,
  );
  static final TextStyle bold = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle black = TextStyle(
    fontFamily: "Poppins",
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      inverseSurface: Colors.black,
      secondary: Color(0xff004a8d),
      primary: Color(0xff00a3e0),
      tertiary: Color.fromARGB(255, 181, 181, 181),
    ),
  );
  static ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      inverseSurface: Colors.white,
      primary: Color(0xff004a8d),
      secondary: Color(0xff00a3e0),
      tertiary: Color.fromARGB(255, 181, 181, 181),
    ),
  );
}

class ThemeProvider {
  static ValueNotifier<ThemeData> themeNotifier = ValueNotifier(
    AppStyle.darkMode,
  );

  static void toggleTheme() {
    themeNotifier.value = themeNotifier.value == AppStyle.darkMode
        ? AppStyle.lightMode
        : AppStyle.darkMode;
  }
}
