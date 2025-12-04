import 'package:flutter/material.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/features/sign_up/sign_up_state.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';
import 'package:fuark_bank/services/secure_storage.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  SignUpController(this._authService, this._secureStorage);

  SignUpState state = SignUpInitialState();

  void changeState(SignUpState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> doSignUp({required UserModel userData}) async {
    changeState(SignUpLoadingState());

    try {
      final user = await _authService.signUp(
        email: userData.email!,
        password: userData.password!,
        name: userData.name,
      );
      if (user.id != null) {
        await _secureStorage.write(key: "CURRENT_USER", value: user.toJson());
        changeState(SignUpSuccessState());
      } else{
        throw Exception();
      }
    } catch (e) {
      changeState(SignUpErrorState(e.toString()));
    }
  }
}
