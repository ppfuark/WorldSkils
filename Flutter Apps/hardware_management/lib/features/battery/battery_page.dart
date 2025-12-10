import 'package:flutter/material.dart';
import 'package:hardware_management/features/battery/battery_controller.dart';
import 'package:hardware_management/features/battery/battery_state.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  late final BatteryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BatteryController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            if (_controller.state is LowAppBatteryState) {
              return Text("Low battery");
            } else if (_controller.state is MediumAppBatteryState) {
              return Text("Medium battery");
            } else {
              return Text("High battery");
            }
          },
        ),
      ),
    );
  }
}
