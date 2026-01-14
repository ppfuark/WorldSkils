import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryController {
  final Battery _battery = Battery();
  StreamSubscription<BatteryState>? _subscription;

  int? _lastTriggerValue;

  void init(GlobalKey<NavigatorState> navigatorKey) {
    _subscription = _battery.onBatteryStateChanged.listen((state) {
      _handleStatusChange(state, navigatorKey);
    });
  }

  void _handleStatusChange(
    BatteryState batteryState,
    GlobalKey<NavigatorState> navigatorKey,
  ) async {
    final context = navigatorKey.currentContext;
    final isLowBattery = (await _battery.batteryLevel <= 20);
    final isExtremeLowBattery = (await _battery.batteryLevel <= 10);

    int? currentTrigger;

    if (isExtremeLowBattery){
      currentTrigger = 10;
    } else if (isLowBattery){
      currentTrigger = 20;
    } else{
      currentTrigger = null;
    }

    if (context!.mounted) {
      if(currentTrigger != _lastTriggerValue){
        _lastTriggerValue = currentTrigger;

        if (currentTrigger == 10) {
          _showLowBatterySnackBar(context, "BATERIA CRÍTICA");
        } else if (currentTrigger == 20) {
          _showLowBatterySnackBar(context, "Bateria baixa");
        } 
        else{
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      }
    }
  }

  void _showLowBatterySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 5)),
    );
  }

  void dispose() {
    _subscription?.cancel();
  }
}
