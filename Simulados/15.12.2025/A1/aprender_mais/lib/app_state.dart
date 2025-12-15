import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isLowBattery = false;
  bool isNoConnection = false;
  bool isDeviceConnected = false;
  bool isInSaveMode = false;

  set setIsLowBattery(bool isLowBattery) {
    this.isLowBattery = isLowBattery;
    notifyListeners();
  }

  set setIsNoConnection(isNoConnection) {
    this.isNoConnection = isNoConnection;
    notifyListeners();
  }

  set setIsDeviceConnected(isDeviceConnected) {
    this.isDeviceConnected = isDeviceConnected;
    notifyListeners();
  }

  set setIsInSaveMode(isInSaveMode) {
    this.isInSaveMode = isInSaveMode;
    notifyListeners();
  }
}
