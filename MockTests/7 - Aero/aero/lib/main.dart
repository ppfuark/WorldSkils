import 'package:aero/app_style.dart';
import 'package:aero/pages/drone_admin_page.dart';
import 'package:aero/pages/drones_page.dart';
import 'package:aero/pages/login_page.dart';
import 'package:aero/pages/register_drones_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Routes());
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
            '/drones': (context) => DronesPage(),
            '/register_drones': (context) => RegisterDronesPage(),
            '/drone_admin': (context) => DroneAdminPage(),
          },
        );
      },
    );
  }
}
