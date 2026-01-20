import 'package:chat_app/feat/settings/settings_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      AuthService authService = AuthService();
      authService.signOut();
    }

    final theme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: theme.surface,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(Icons.message, color: theme.primary, size: 40),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: Text("HOME"),
                    leading: Icon(Icons.home, color: theme.primary),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: Text("SETTINGS"),
                    leading: Icon(Icons.settings, color: theme.primary),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: Text("LOG OUT"),
                leading: Icon(Icons.logout, color: theme.primary),
                onTap: logOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
