import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt_auth_app/common/models/user_model.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async{
    try{
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      if(result.user != null){
        return UserModel(
          name: result.user!.displayName,
          email: result.user!.email,
          id: result.user!.uid,
        );
      } else {
        throw Exception("Can not find user. Try again!");
      }
    } on FirebaseException catch(e){
      throw e.message ?? "";
    } catch (e){
      rethrow;
    }
  }

  void signOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      rethrow;
    }
  }  
}