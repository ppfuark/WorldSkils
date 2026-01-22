import 'package:estudy/common/app_button.dart';
import 'package:estudy/common/app_text_field.dart';
import 'package:estudy/features/auth/register_page.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void singIn() async {
    final AuthService authService = AuthService();

    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      try {
        await authService.singIn(
          _emailController.text,
          _passwordController.text,
        );
      } on Exception catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Campos não podem estar vazios"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 50,
            top: 160,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bem-vindo",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: theme.tertiary,
                    ),
                  ),
                  SizedBox(height: 50),
                  AppTextField(
                    icon: Icons.email_outlined,
                    label: "E-mail",
                    hintText: "seu@email.com",
                    isPasswordField: false,
                    controller: _emailController,
                  ),
                  SizedBox(height: 25),
                  AppTextField(
                    icon: Icons.lock_outline,
                    label: "Senha",
                    hintText: "senha123@",
                    isPasswordField: true,
                    controller: _passwordController,
                  ),
                  SizedBox(height: 50),
                  AppButton(label: "ENTRAR", onTap: singIn),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Não tem uma conta?"),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(
                        color: theme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
