import 'package:chat_app/common/widgets/app_button.dart';
import 'package:chat_app/common/widgets/app_text_field.dart';
import 'package:chat_app/feat/auth/login/login_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  final confirmPasswordContoller = TextEditingController();

  void signUp() async {
    try {
      if (passwordContoller.text != confirmPasswordContoller.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords don't match!"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        AuthService authService = AuthService();
        UserCredential userCredential = await authService.signUpEmailPassword(
          emailContoller.text,
          passwordContoller.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User created!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
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
              "Create a new account",
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
            SizedBox(height: 10),
            AppTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: confirmPasswordContoller,
            ),
            SizedBox(height: 25),
            AppButton(text: "Register", onTap: signUp),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Alredy have an account?",
                    style: TextStyle(color: theme.primary),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login",
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
