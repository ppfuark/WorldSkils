import 'dart:developer';

import 'package:aprender_mais/app_state.dart';
import 'package:aprender_mais/features/teste.dart';
import 'package:aprender_mais/main.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Battery _battery = Battery();
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    // Register listener for AppState changes
    context.watch<AppState>().addListener(_appStateListener);

    _checkBattery();
    _checkConnection();
  }

  @override
  void dispose() {
    // Clean up listener when the widget is disposed
    context.read<AppState>().removeListener(_appStateListener);
    super.dispose();
  }

  // Listener to handle changes in AppState
  void _appStateListener() {
    log("AppState changed");
  }

  // Check the battery status
  Future<void> _checkBattery() async {
    int batteryLevel = await _battery.batteryLevel;
    bool isInSaveMode = await _battery.isInBatterySaveMode;

    if (mounted) {
      context.read<AppState>().setIsLowBattery = (batteryLevel <= 20);
      context.read<AppState>().setIsInSaveMode = isInSaveMode;
    }
  }

  // Check the network connection
  Future<void> _checkConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    if (mounted) {
      context.read<AppState>().setIsNoConnection = (connectivityResult == ConnectivityResult.none);
    }
  }

  // Display appropriate message based on the state
  Widget _displayText() {
    final AppState appState = context.watch<AppState>();

    if (appState.isNoConnection) {
      return const Text(
        "Sem conexão com internet, seus dados podem não estar completamente salvos.",
      );
    }
    if (appState.isInSaveMode) {
      return const Text(
        "Seu dispositivo está no modo economia de energia, alguns recursos podem ser limitados.",
      );
    }
    if (appState.isLowBattery) {
      return const Text("Atenção. Bateria Baixa.");
    }

    return const Text("Sistema funcionando normalmente.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Color(0x00fcfcfc)),
          child: Center(child: _displayText()),
        ),
      ),
    );
  }
}
