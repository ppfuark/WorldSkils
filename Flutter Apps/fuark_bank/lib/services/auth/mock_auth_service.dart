import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (password.startsWith("123")) {
        throw Exception();
      }
      throw Exception();
      return UserModel(id: 7, email: email, name: name);
    } catch (e) {
      if (password.startsWith("123")) {
        throw "Weak password. Try again!";
      }
      throw "Can not create your accont. Try again later!";
    }
  }
}
