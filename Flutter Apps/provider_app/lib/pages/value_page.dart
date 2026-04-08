import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/controller/counter_controller.dart';

class ValuePage extends StatefulWidget {
  const ValuePage({super.key});

  @override
  State<ValuePage> createState() => _ValuePageState();
}

class _ValuePageState extends State<ValuePage> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(),
        child: Column(
          children: [Text(context.watch<CounterController>().value.toString())],
        ),
      ),
    );
  }
}
