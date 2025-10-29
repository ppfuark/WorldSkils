import 'dart:ui';

class AppColors {
  AppColors._();

  static const Color primaryColor = Color(0xFFE57627);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secoundary = Color(0xFF424242);
  static const Color tertiary = Color(0xFFBCBCBC);

  static final List<Color> grayBlackGradiant = [
    Color(0xFF424242),
    Color(0xFF000000),
  ];
  static final List<Color> orangesGradiant = [primaryColor, Color(0xFFB94D00)];
}
