import 'package:flutter/material.dart';
import 'package:state_ful_andl_less/components/ColorCard.dart';
import 'package:state_ful_andl_less/pages/AddColorPage.dart';

class Buttonpage extends StatelessWidget {
  const Buttonpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}