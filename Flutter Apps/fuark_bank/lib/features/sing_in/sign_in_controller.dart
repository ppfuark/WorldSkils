import 'package:flutter/material.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/features/sing_in/sign_in_state.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService;

  SignInController(this._authService);

  SignInState state = SignInInitialState();
  void changeState(SignInState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> doSignIn({required UserModel userData}) async {
    changeState(SignInLoadingState());

    try {
      await _authService.signIn(
        email: userData.email!,
        password: userData.password!,
      );
      changeState(SignInSuccessState());
    } catch (e) {
      changeState(SignInErrorState(e.toString()));
    }
  }
}
