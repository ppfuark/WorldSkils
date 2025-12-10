import 'package:flutter/material.dart';
import 'package:hardware_management/features/network/network_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends ChangeNotifier {
  AppNetworkState state = AppNetworkStateInitial();
  
  final Future<List<ConnectivityResult>> connectivityResult = (Connectivity().checkConnectivity());

}