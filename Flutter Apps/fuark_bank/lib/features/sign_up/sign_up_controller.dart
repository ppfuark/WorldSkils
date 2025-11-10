import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuark_bank/features/sign_up/sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  SignUpState state = SignUpInitialState();

  void changeState(SignUpState newState) {
    state = newState;
    notifyListeners();
  }

  Future<bool> doSignUp() async {
    changeState(SignUpLoadingState());

    try{
      await Future.delayed(const Duration(seconds: 2));

      // throw Exception("Unexpected Error in SignUp. Try again.");
      log("LOGINNNNNNNNNNNNNNN");
      changeState(SignUpSuccessState());
      return true;
    }catch(e){
      changeState(SignUpErrorState());
      return false;
    }

  }
}
