import 'package:flutter/material.dart';
import 'package:fuark_bank/features/sign_up/sign_up_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SignUpPage()),
    );
  }
}
