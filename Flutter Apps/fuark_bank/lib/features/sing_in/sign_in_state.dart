abstract class SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInErrorState extends SignInState {
  final String errorMessage;
  SignInErrorState(this.errorMessage);
}

class SignInInitialState extends SignInState {}
