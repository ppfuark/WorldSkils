import 'package:flutter_test/flutter_test.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/features/sign_up/sign_up_controller.dart';
import 'package:fuark_bank/features/sign_up/sign_up_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late SignUpController signUpController;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late MockSecureStorage mockSecureStorage;

  late UserModel user;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorage = MockSecureStorage();
    signUpController = SignUpController(
      mockFirebaseAuthService,
      mockSecureStorage,
    );
    user = UserModel(
      name: "User",
      email: "user@mail.com",
      password: "User@123",
      id: "1a2b3c4d5e",
    );
  });

  group("Sign Up Tests", () {
    test("Tests Sign Up Controller, Sucess State", () async {
      expect(signUpController.state, isInstanceOf<SignUpInitialState>());

      when(
        () =>
            mockSecureStorage.write(key: "CURRENT_USER", value: user.toJson()),
      ).thenAnswer((_) async {});

      when(
        () => mockFirebaseAuthService.signUp(
          name: "User",
          email: "user@mail.com",
          password: "User@123",
        ),
      ).thenAnswer((_) async => user);

      await signUpController.doSignUp(userData: user);
      expect(signUpController.state, isInstanceOf<SignUpSuccessState>());
    });

    test("Tests Sign Up Controller, Error State", () async {
      expect(signUpController.state, isInstanceOf<SignUpInitialState>());

      when(
        () =>
            mockSecureStorage.write(key: "CURRENT_USER", value: user.toJson()),
      ).thenAnswer((_) async {});

      when(
        () => mockFirebaseAuthService.signUp(
          name: "User",
          email: "user@mail.com",
          password: "User@123",
        ),
      ).thenThrow(Exception());

      await signUpController.doSignUp(userData: user);
      expect(signUpController.state, isInstanceOf<SignUpErrorState>());
    });
  });
}
