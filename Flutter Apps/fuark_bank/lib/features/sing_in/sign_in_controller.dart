import 'package:flutter/material.dart';
import 'package:fuark_bank/features/sing_in/sign_in_state.dart';

class SignInController extends ChangeNotifier {

  SignInState state = SignInInitialState();
  void changeState(SignInState newState) {
    state = newState;
    notifyListeners();
  }
}