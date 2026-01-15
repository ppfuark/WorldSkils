import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkController {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void init(GlobalKey<NavigatorState> navigatorKey) {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _handleStatusChange(results, navigatorKey);
    });
  }

  void _handleStatusChange(
    List<ConnectivityResult> results,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    final context = navigatorKey.currentContext;

    final hasNoConnection = results.contains(ConnectivityResult.none);

    if (hasNoConnection) {
      _showNoConnectionDialog(context!);
    } else {
      if (Navigator.of(context!).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  void _showNoConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("Você está sem internet!"),
          actions: [CircularProgressIndicator()],
        );
      },
    );
  }

  void dispose(){
    _subscription?.cancel();
  }
}
