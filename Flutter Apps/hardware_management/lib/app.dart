import 'package:flutter/material.dart';
import 'package:hardware_management/features/battery/battery_page.dart';
import 'package:hardware_management/features/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(inputDecorationTheme: In),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context)=>const HomePage(),
        "/battery": (context)=>const BatteryPage(),
      },
    );
  }
}