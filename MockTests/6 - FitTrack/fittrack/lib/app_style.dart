import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static final TextStyle regular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
  );
  static final TextStyle bold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle black = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static final ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      inverseSurface: Colors.black,
      primary: Color(0xFF39cd54),
      secondary: Color(0xFF227b32),
      tertiary: Colors.grey.shade400,
    ),
  );

  static final ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.black,
      inverseSurface: Colors.white,
      secondary: Color(0xFF39cd54),
      primary: Color(0xFF227b32),
      tertiary: Colors.grey.shade400,
    ),
  );
}

class ThemeNotifier {
  static final ValueNotifier<ThemeData> themeNotifier = ValueNotifier(
    AppStyle.darkMode,
  );

  static void toggleTheme() {
    themeNotifier.value = themeNotifier.value == AppStyle.darkMode
        ? AppStyle.lightMode
        : AppStyle.darkMode;
  }
}
