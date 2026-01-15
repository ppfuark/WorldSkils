import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_colors/components/ColorCard.dart';

class Addcolor extends StatefulWidget {
  final Color currentColor;
  final Function(Color) onColorChanged;
  
  const Addcolor({
    super.key,
    required this.currentColor,
    required this.onColorChanged,
  });

  @override
  State<Addcolor> createState() => _AddcolorState();
}

class _AddcolorState extends State<Addcolor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Color", style: TextStyle(color: Colors.white),),
        backgroundColor: widget.currentColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Colorcard(color: widget.currentColor),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onColorChanged(
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
                );
              },
              child: Text("Change Color", style: TextStyle(color: widget.currentColor)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}