import 'package:flutter/material.dart';
import 'package:yt_auth_app/features/auth/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  LoginPage(),
    );
  }
}

