import 'package:estudy/common/app_tile.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciamento de Usuários"),
        foregroundColor: theme.tertiary,
        backgroundColor: Colors.transparent,
      ),
      body: Expanded(
        child: StreamBuilder(
          stream: authService.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text("Nenhum usuário encontrado!"));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Erro na busca de usuários"));
            }

            return ListView(
              children: snapshot.data!
                  .map<Widget>((userData) => _buildUserItem(userData, context))
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: AppTile(
        title: userData["email"],
        subtitle: userData["user_level"],
        icon: Icons.person_outline,
        isDeletable: true,
        isEditable: true,
      ),
    );
  }
}
