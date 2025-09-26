import 'package:flutter/material.dart';
import 'package:random_colors/components/ColorCard.dart';

class Homepage extends StatefulWidget {
  final Color color;
  
  const Homepage({super.key, required this.color});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home - Current Color", style: TextStyle(color: Colors.white),),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Color",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Colorcard(color: widget.color),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}