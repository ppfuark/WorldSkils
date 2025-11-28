import 'package:fuark_bank/features/sign_up/sign_up_controller.dart';
import 'package:fuark_bank/features/sing_in/sign_in_controller.dart';
import 'package:fuark_bank/features/splash/splash_controller.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';
import 'package:fuark_bank/services/auth/firebase_auth_service.dart';
import 'package:fuark_bank/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  locator.registerFactory<SignInController>(
    () => SignInController(locator.get<AuthService>()),
  );
  locator.registerFactory<SignUpController>(
    () => SignUpController(locator.get<AuthService>()),
  );

  locator.registerFactory<SplashController>(
    () => SplashController(const SecureStorage()),
  );
}
