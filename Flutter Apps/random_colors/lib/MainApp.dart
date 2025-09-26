import 'package:flutter/material.dart';
import 'package:random_colors/pages/AddColorPage.dart';
import 'package:random_colors/pages/HomePage.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Color _currentColor = Colors.black;
  int _currentIndex = 0;

  void _changeColor(Color newColor) {
    setState(() {
      _currentColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Homepage(color: _currentColor),
          Addcolor(currentColor: _currentColor, onColorChanged: _changeColor),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Color'),
        ],
      ),
    );
  }
}
