import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/services/auth/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(
          name: result.user!.displayName,
          email: result.user!.email,
          id: result.user!.uid,
        );
      } else {
        throw Exception("Can not find user. Try again!");
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        result.user!.updateDisplayName(name);
        return UserModel(
          name: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
          id: _auth.currentUser?.uid,
        );
      } else {
        throw Exception("User can not be null. Try again!");
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      rethrow;
    }
  }
}
