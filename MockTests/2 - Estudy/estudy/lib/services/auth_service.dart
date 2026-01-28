import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> singIn(String email, String password) async {
    try {
      final query = await _firestore
          .collection("Users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty && query.docs.first.data()['blocked'] == true) {
        throw Exception("Conta bloqueada. Contate o adminstrador.");
      }

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
      final query = await _firestore
          .collection("Users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty && query.docs.first.data()['blocked'] == true) {
        throw Exception("Conta bloqueada. Contate o adminstrador.");
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'createAt': FieldValue.serverTimestamp(),
        'user_level': 'Student',
        'blocked': false,
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

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  Future<bool> isAdmin(String uid) async {
    final doc = await _firestore.collection("Users").doc(uid).get();
    final data = doc.data();
    return data?["user_level"] == "Admin";
  }

  Future<bool> isTeacher(String uid) async {
    final doc = await _firestore.collection("Users").doc(uid).get();
    final data = doc.data();
    return data?["user_level"] == "Professor";
  }

  Future<List<int>> getTeacherCoursesId(String uid) async {
    final doc = await _firestore.collection("Users").doc(uid).get();
    final data = doc.data();
    if (data == null) return [];

    return List<int>.from(data["courses_references"] ?? []);
  }

  Future<void> blockUser(String uid) async {
    await _firestore.collection("Users").doc(uid).update({'blocked': true});
  }

  Future<void> unBlockUser(String uid) async {
    await _firestore.collection("Users").doc(uid).update({'blocked': false});
  }

  Future<void> updateUser(String uid, Map<String, dynamic> userData) async {
    await _firestore.collection("Users").doc(uid).update(userData);
  }
}
