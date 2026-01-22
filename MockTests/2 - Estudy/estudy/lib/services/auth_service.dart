import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> singIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Erro no login");
    }
  }

  Future<UserCredential> singUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'createAt': FieldValue.serverTimestamp(),
        'user_level': 'Student',
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Erro no registro");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() => _auth.currentUser;

  Stream<DocumentSnapshot> getUser(String userId) {
    return _firestore.collection("Users").doc(userId).snapshots();
  }
}
