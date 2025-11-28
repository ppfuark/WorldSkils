import 'package:flutter/material.dart';
import 'package:fuark_bank/features/splash/splash_state.dart';
import 'package:fuark_bank/services/secure_storage.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage _authService;

  SplashController(this._authService);
  SplashState state = SplashInitialState();
  void changeState(SplashState newState) {
    state = newState;
    notifyListeners();
  }

  void isUserLogged() async {
    final result = await _authService.readOne(key: "CURRENT_USER");

    result != null ? changeState(SplashSuccessState()) : changeState(SplashErrorState("User do not have logged before"));
  }
}
