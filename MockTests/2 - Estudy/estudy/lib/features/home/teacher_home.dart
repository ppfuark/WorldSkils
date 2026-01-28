import 'package:estudy/services/auth_service.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  final AuthService authService = AuthService();
  late Future<List<int>> coursesReference;

  @override
  void initState() {
    super.initState();
    coursesReference = authService.getTeacherCourses(
      authService.getCurrentUser()!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área do Professor"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              final AuthService authService = AuthService();
              authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
