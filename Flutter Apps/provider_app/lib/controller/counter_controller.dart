import 'package:flutter/material.dart';

class CounterController extends ChangeNotifier {
  int value;

  CounterController({this.value = 0});

  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
    value <= 0 ? value = 0 : value--;
    notifyListeners();
  }
}
