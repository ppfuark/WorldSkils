import 'dart:math';

import 'package:flutter/material.dart';
import 'package:state_ful_andl_less/components/ColorCard.dart';

class Addcolor extends StatefulWidget {
  const Addcolor({super.key});

  @override
  State<Addcolor> createState() => _AddcolorState();

}

class _AddcolorState extends State<Addcolor> {
  Color _color = Colors.black;

  Color get getColor => _color;

  void setColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Colorcard(color: _color),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setColor(
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
                );
              },
              child: Text("Change Color", style: TextStyle(color: _color)),
            ),
          ],
        ),
      ),
    );
  }
}
