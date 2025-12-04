import 'package:flutter_test/flutter_test.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_classes.dart';

void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
  });

  final user = UserModel(
    name: "User",
    email: "user@mail.com",
    id: "1a2b3c4d5e",
  );

  group("Tests SignUp", () {
    test("Test sign up sucess", () async {
      when(
        () => mockFirebaseAuthService.signUp(
          name: "User",
          email: "user@mail.com ",
          password: "User@123",
        ),
      ).thenAnswer((_) async => user);

      final result = await mockFirebaseAuthService.signUp(
        name: "User",
        email: "user@mail.com ",
        password: "User@123",
      );

      expect(result, user);
    });

    test("Test sign up failure", () async {
      when(
        () => mockFirebaseAuthService.signUp(
          name: "User",
          email: "user@mail.com ",
          password: "User@123",
        ),
      ).thenThrow(Exception());

      expect(
        () => mockFirebaseAuthService.signUp(
          name: "User",
          email: "user@mail.com ",
          password: "User@123",
        ),
        throwsException,
      );
    });
  });
}
