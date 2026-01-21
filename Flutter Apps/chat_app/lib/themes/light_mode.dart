import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  dividerTheme: const DividerThemeData(color: Colors.transparent),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
);
