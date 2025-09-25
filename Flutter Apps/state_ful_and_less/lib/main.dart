import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Statefull X Stateless", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple,
        ),
        body: Center(child: ElevatedButton(onPressed: (){}, child: Text("Click"))),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Add",icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: "Home",icon: Icon(Icons.home)),
        ],),
      ),
    );
  }
}
