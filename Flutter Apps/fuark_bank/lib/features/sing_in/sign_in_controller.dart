import 'package:flutter/material.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/features/sing_in/sign_in_state.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';
import 'package:fuark_bank/services/secure_storage.dart';

class SignInController extends ChangeNotifier {
  final AuthService _authService;

  SignInController(this._authService);

  SignInState state = SignInInitialState();
  void changeState(SignInState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> doSignIn({required UserModel userData}) async {
    final _secureStorage = SecureStorage();
    changeState(SignInLoadingState());

    try {
      final user = await _authService.signIn(
        email: userData.email!,
        password: userData.password!,
      );
      if (user.id != null) {
        await _secureStorage.write(key: "CURRENT_USER", value: user.toJson());
        changeState(SignInSuccessState());
      } else {
        throw Exception();
      }
    } catch (e) {
      changeState(SignInErrorState(e.toString()));
    }
  }
}
