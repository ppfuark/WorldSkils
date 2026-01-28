import 'package:estudy/common/app_drawer.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
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
      body: Center(
        child: StreamBuilder(
          stream: _authService.getUser(_authService.getCurrentUser()!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return Text("Usuário não encontrado!");
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final userLeve = data["user_level"];

            return Text(userLeve);
          },
        ),
      ),
    );
  }
}
