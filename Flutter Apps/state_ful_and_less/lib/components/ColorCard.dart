import 'package:flutter/material.dart';

class Colorcard extends StatelessWidget {
  const Colorcard({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: color, spreadRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      padding: EdgeInsets.all(10.0),
      child: Center(child: Text(color.toString(), style: TextStyle(color: Colors.white),)),
    );
  }
}
