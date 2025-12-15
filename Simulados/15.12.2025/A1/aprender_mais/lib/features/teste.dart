import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryStatusPage extends StatefulWidget {
  const BatteryStatusPage({super.key});

  @override
  State<BatteryStatusPage> createState() => _BatteryStatusPageState();
}

class _BatteryStatusPageState extends State<BatteryStatusPage> {
  final Battery _battery = Battery();
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    // Initialize the battery state and start listening for changes
    _updateBatteryState();
    _startBatteryStateListener();
  }

  // Get the initial battery state once
  Future<void> _updateBatteryState() async {
    final state = await _battery.batteryState;
    if (mounted) {
      setState(() {
        _batteryState = state;
      });
    }
  }

  // Set up the listener for real-time updates
  void _startBatteryStateListener() {
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  @override
  void dispose() {
    // Crucial: Cancel the subscription in dispose() to avoid memory leaks
    _batteryStateSubscription?.cancel();
    super.dispose();
  }

  // Helper method to get a readable string from the enum
  String _batteryStateString(BatteryState? state) {
    switch (state) {
      case BatteryState.full:
        return 'Full';
      case BatteryState.charging:
        return 'Charging';
      case BatteryState.discharging:
        return 'Discharging';
      case BatteryState.unknown:
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Plus Listener'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.battery_saver, size: 100),
            const SizedBox(height: 20),
            Text(
              'Current Battery State: ${_batteryStateString(_batteryState)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
