import 'package:flutter/material.dart';
import 'package:provider_app/pages/counter_page.dart';
import 'package:provider_app/pages/value_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> wids = [CounterPage(), ValuePage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Counter"),
          BottomNavigationBarItem(icon: Icon(Icons.numbers), label: "Value"),
        ],
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
        currentIndex: currentIndex,
      ),
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(),
        child: wids[currentIndex],
      ),
    );
  }
}
