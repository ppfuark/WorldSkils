import 'package:fittrack/app_style.dart';
import 'package:fittrack/pages/login_page.dart';
import 'package:fittrack/pages/workout_register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Routes());
}

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeNotifier.themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          theme: currentTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: "/login",
          routes: {
            '/login': (context) => LoginPage(),
            '/workout_register': (context) => WorkoutRegister(),
          },
        );
      },
    );
  }
}
