import 'package:flutter/material.dart';
import 'package:state_ful_andl_less/components/ButtonNavigationBar.dart';
import 'package:state_ful_andl_less/pages/ButtonPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statefull X Stateless",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Buttonpage()));
          },
          child: const Text("Click"),
        ),
      ),
      bottomNavigationBar: Buttonnavigationbar(
        barItems: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Add", icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}