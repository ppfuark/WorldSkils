import 'package:estudy/features/auth/login_page.dart';
import 'package:estudy/features/home/teacher_home.dart';
import 'package:estudy/features/home_page.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const LoginPage();
          } else {
            return FutureBuilder<Widget>(
              future: verifyUserHome(snapshot.data!.uid),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                return roleSnapshot.data ?? const HomePage();
              },
            );
          }
        },
      ),
    );
  }

  Future<Widget> verifyUserHome(String uid) async {
    final AuthService authService = AuthService();

    if (await authService.isAdmin(uid)) {
      return HomePage();
    } else if (await authService.isTeacher(uid)) {
      return TeacherHome();
    } else {
      return HomePage();
    }
  }
}
