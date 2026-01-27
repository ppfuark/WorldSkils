import 'package:estudy/features/admin/users_page.dart';
import 'package:estudy/features/courses/courses_page.dart';
import 'package:estudy/features/disciplines/disciplines_page.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final theme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: theme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(Icons.book_outlined, color: theme.primary, size: 40),
          ),
          FutureBuilder<bool>(
            future: authService.isAdmin(authService.getCurrentUser()!.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }

              if (!snapshot.data!) {
                return const SizedBox.shrink();
              }

              return ListTile(
                title: Text(
                  "U S U Á R I O S",
                  style: TextStyle(color: theme.primary),
                ),
                leading: Icon(
                  Icons.admin_panel_settings_outlined,
                  color: theme.primary,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsersPage()),
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text("C U R S O S", style: TextStyle(color: theme.primary)),
            leading: Icon(Icons.school, color: theme.primary),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursesPage()),
              );
            },
          ),
          ListTile(
            title: Text(
              "D I C I P L I N A S",
              style: TextStyle(color: theme.primary),
            ),
            leading: Icon(Icons.book, color: theme.primary),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisciplinesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
