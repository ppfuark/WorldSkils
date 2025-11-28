abstract class SplashState {}
class SplashLoadingState extends SplashState {}
class SplashSuccessState extends SplashState {}
class SplashErrorState extends SplashState {
  final String errorMessage;
  SplashErrorState(this.errorMessage);}
class SplashInitialState extends SplashState {}