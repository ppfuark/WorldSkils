import 'package:flutter/material.dart';
import 'package:health_tech/app_style.dart';
import 'package:health_tech/pages/login_page.dart';
import 'package:health_tech/pages/management_animal_page.dart';
import 'package:health_tech/pages/register_animal_page.dart';

Future<void> main() async {
  runApp(Routes());
}

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeProvider.themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          theme: currentTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => LoginPage(),
            '/register_animal': (context) => RegisterAnimalPage(),
            '/management_animal': (context) => ManagementAnimalPage(),
          },
        );
      },
    );
  }
}
