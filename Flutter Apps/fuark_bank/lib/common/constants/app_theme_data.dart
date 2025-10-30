import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';

class AppThemeData {
  AppThemeData._();

  static  ThemeData themeData = ThemeData(inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)
        ),
      ));
}