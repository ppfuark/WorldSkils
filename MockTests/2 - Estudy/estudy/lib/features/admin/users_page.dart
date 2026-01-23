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
                  .map<Widget>((userData) => _buildUserItem(userData))
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData) {
    final AuthService authService = AuthService();

    if (userData['email'] == authService.getCurrentUser()!.email) {
      return SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: AppTile(
          title: userData["email"],
          subtitle: userData["user_level"],
          icon: Icons.person_outline,
          isDeletable: true,
          onDelete: () => _showBlockodal(userData, context),
          isEditable: true,
          block: true,
        ),
      );
    }
  }

  void _showBlockodal(
    Map<String, dynamic> userData,
    BuildContext context,
  ) async {
    final bool isBlocked = userData['blocked'];

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isBlocked
              ? Text("Você realmente deseja desbloquear o usuário?")
              : Text("Você realmente deseja bloquear o usuário?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                final AuthService authService = AuthService();
                isBlocked
                    ? authService.unBlockUser(userData['uid'])
                    : authService.blockUser(userData['uid']);
                Navigator.pop(context);
              },
              child: isBlocked ? Text("Desbloquear") : Text("Bloquear"),
            ),
          ],
        );
      },
    );
  }
}
