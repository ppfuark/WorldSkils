import 'package:flutter/material.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/features/sign_up/sign_up_state.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';

class SignUpController extends ChangeNotifier {
  
  final AuthService _authService;

  SignUpController(this._authService);

  SignUpState state = SignUpInitialState();

  void changeState(SignUpState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> doSignUp({required UserModel userData}) async {
    changeState(SignUpLoadingState());

    try {
      await _authService.signUp(email: userData.email!, password: userData.password!, name: userData.name);
      changeState(SignUpSuccessState());
    } catch (e) {
      changeState(SignUpErrorState(e.toString()));
    }
  }
}
