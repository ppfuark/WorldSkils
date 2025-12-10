import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:hardware_management/features/battery/battery_state.dart';

class BatteryController extends ChangeNotifier {
  AppBatteryState state = InitialAppBatteryState();

  void changeState(AppBatteryState newState) {
    state = newState;
    notifyListeners();
  }

  BatteryController() {
    batteryLevel();
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      batteryLevel();
    });
    notifyListeners();
  }

  final _battery = Battery();

  Future<void> batteryLevel() async {
    int batterryLevel = await _battery.batteryLevel;

    if (batterryLevel >= 80) {
      changeState(HighAppBatteryState());
    } else if (batterryLevel >= 20) {
      changeState(MediumAppBatteryState());
    } else {
      changeState(LowAppBatteryState());
    }
  }
}
