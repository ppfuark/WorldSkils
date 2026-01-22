import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  dividerTheme: const DividerThemeData(color: Colors.transparent),
  iconTheme: IconThemeData(color: Colors.grey.shade400),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.deepPurpleAccent,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade900,
  ),
);
