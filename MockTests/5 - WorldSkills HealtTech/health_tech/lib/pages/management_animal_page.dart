import 'package:flutter/material.dart';

class ManagementAnimalPage extends StatefulWidget {
  const ManagementAnimalPage({super.key});

  @override
  State<ManagementAnimalPage> createState() => _ManagementAnimalPageState();
}

class _ManagementAnimalPageState extends State<ManagementAnimalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AA")),
      body: SafeArea(
        top: true,
        child: Center(
          child: Padding(padding: const EdgeInsets.all(25.0), child: Column()),
        ),
      ),
    );
  }
}
