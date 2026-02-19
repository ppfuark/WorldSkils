import 'dart:convert';

import 'package:aero/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool showPass = false;

  void login() async {
    final response = await http.get(
      Uri.parse("http://10.109.66.116:3000/usuarios"),
    );

    if (response.statusCode == 200 &&
        emailController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      final data = jsonDecode(response.body);

      for (var user in data) {
        if (mounted &&
            user['email'] == emailController.text &&
            user['senha'] == passController.text) {
          Navigator.pushNamed(context, '/drones');
          return;
        }
      }
    } else {
      mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Campos vazios ou credenciais incorretas."),
                backgroundColor: Colors.red,
              ),
            )
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text(
          "Login Page",
          style: AppStyle.bold.copyWith(
            color: theme.inverseSurface,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ThemeProvider.toggleTheme();
              });
            },
            icon: (ThemeProvider.themeNotifier.value == AppStyle.lightMode)
                ? Icon(Icons.light_mode_outlined)
                : Icon(Icons.dark_mode_outlined),
            color: theme.inverseSurface,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Uma nova forma de",
                        style: AppStyle.black.copyWith(color: theme.secondary),
                      ),
                      Text(
                        "cuidar de sua fazenda!",
                        style: AppStyle.black.copyWith(color: theme.secondary),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: AppStyle.bold),
                      TextField(
                        style: AppStyle.regular,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primary),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintStyle: AppStyle.regular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Senha", style: AppStyle.bold),
                      TextField(
                        obscureText: !showPass,

                        style: AppStyle.regular,
                        controller: passController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPass = !showPass;
                              });
                            },
                            icon: showPass
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            color: theme.secondary,
                          ),
                          hintText: "Senha",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primary),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintStyle: AppStyle.regular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 300),
                  GestureDetector(
                    onTap: login,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: theme.secondary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: Text(
                          "Logar",
                          style: AppStyle.bold.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: theme.primary, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "Solicitar Acesso",
                        style: AppStyle.bold.copyWith(
                          color: theme.inverseSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
