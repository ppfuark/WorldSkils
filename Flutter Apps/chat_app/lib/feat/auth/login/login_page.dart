import 'package:chat_app/common/widgets/app_button.dart';
import 'package:chat_app/common/widgets/app_text_field.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  void singIn() {
    try {
      final AuthService authService = AuthService();

      authService.signInEmailPassword(
        emailContoller.text,
        passwordContoller.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Deu bom"), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 60, color: theme.primary),
            const SizedBox(height: 50),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(color: theme.primary, fontSize: 16),
            ),
            SizedBox(height: 25),
            AppTextField(
              hintText: "Email",
              obscureText: false,
              controller: emailContoller,
            ),
            SizedBox(height: 10),
            AppTextField(
              hintText: "Password",
              obscureText: true,
              controller: passwordContoller,
            ),
            SizedBox(height: 25),
            AppButton(text: "Login", onTap: singIn),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Not a member?", style: TextStyle(color: theme.primary)),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
