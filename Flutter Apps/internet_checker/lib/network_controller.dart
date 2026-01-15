import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  void updateConnectionStatus(List<ConnectivityResult> results) {
    // Check if the list contains 'none' (meaning no internet)
    if (results.contains(ConnectivityResult.wifi) || results.isEmpty) {
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
          messageText: const Text(
            "PLEASE CONNECT TO THE INTERNET",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          duration: const Duration(days: 1), // Keeps it visible until fixed
          backgroundColor: Colors.red[400]!,
          icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35),
          snackStyle: SnackStyle.GROUNDED,
        );
      }
    } else {
      // If we have mobile data, wifi, or ethernet, close the snackbar
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
