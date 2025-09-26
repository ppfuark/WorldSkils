import 'package:flutter/material.dart';

class Buttonnavigationbar extends StatelessWidget {
  const Buttonnavigationbar({super.key, required this.barItems, required this.children});

  final List<Widget> children;

  final List<BottomNavigationBarItem> barItems;

  List<BottomNavigationBarItem> getList() { 
    return barItems.map((item) {
      return BottomNavigationBarItem(icon: item.icon, label: item.label);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (barItems.length < 2) {
      return Text(
          "Insufficient barItems, you still need ${2 - barItems.length}");
    } else {
      return BottomNavigationBar(
        items: [...getList()],
      );
    }
  }
}