import 'package:flutter/material.dart';
import 'package:go_skiing/pages/game_page.dart';
import 'package:go_skiing/pages/ranking_page.dart';
import 'package:go_skiing/pages/setting_page.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GoSkiingApp());
}

class GoSkiingApp extends StatelessWidget {
  const GoSkiingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Skiing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/home': (context) => const HomePage(),
        '/game': (context) => const GamePage(),
        '/setting': (context) => const SettingPage(),
        '/rank': (context) => const RankingPage(),
      },
      initialRoute: '/home',
    );
  }
}
