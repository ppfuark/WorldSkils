import 'dart:collection';

import 'package:estudy/common/app_text_field.dart';
import 'package:estudy/common/app_tile.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciamento de Usuários"),
        foregroundColor: theme.tertiary,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: authService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro na busca de usuários"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Nenhum usuário encontrado!"));
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserItem(userData))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData) {
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
          onEdit: () => _showEditForm(userData, context),
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

  void _showEditForm(Map<String, dynamic> userData, BuildContext context) {
    List<String> userLevels = <String>["Estudante", "Professor", "Admin"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar usuário"),
          content: SizedBox(
            width: 250,
            height: 250,
            child: Column(
              children: [
                AppTextField(
                  icon: Icons.numbers_outlined,
                  label: "uid",
                  hintText: userData['uid'],
                  isPasswordField: false,
                  enabled: false,
                ),
                SizedBox(height: 10),
                AppTextField(
                  icon: Icons.email,
                  label: "Email",
                  hintText: userData['email'],
                  isPasswordField: false,
                  enabled: false,
                ),
                SizedBox(height: 10),
                DropdownMenu<String>(
                  expandedInsets: EdgeInsets.zero,
                  initialSelection: userData['user_level'],
                  onSelected: (value) {
                    if (value != null) {
                      userData["user_level"] = value;
                    }
                  },
                  dropdownMenuEntries:
                      UnmodifiableListView<DropdownMenuEntry<String>>(
                        userLevels
                            .map(
                              (level) => DropdownMenuEntry<String>(
                                style: ButtonStyle(),
                                value: level,
                                label: level,
                              ),
                            )
                            .toList(),
                      ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await authService.updateUser(userData["uid"], {
                  "user_level": userData["user_level"],
                });
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Update"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
