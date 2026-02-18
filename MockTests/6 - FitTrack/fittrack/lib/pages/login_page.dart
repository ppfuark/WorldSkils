import 'dart:convert';
import 'dart:developer';

import 'package:fittrack/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();
  bool showPass = false;

  void login() async {
    if (emailController.text.isNotEmpty && passwordContoller.text.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse("http://10.109.66.116:3000/users"),
        );

        final List<dynamic> users = jsonDecode(response.body);

        for (dynamic user in users) {
          if (user['email'] == emailController.text &&
              user['password'] == passwordContoller.text) {
            mounted ? Navigator.pushNamed(context, '/workout_register') : null;
          } else {
            mounted
                ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Invalid credentials"),
                      backgroundColor: Colors.red,
                    ),
                  )
                : null;
          }
        }

        log(users.toString());
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error on fecth users: ${e.toString()}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.surface,
        title: Text(
          "Sign in",
          style: AppStyle.bold.copyWith(color: theme.primary),
        ),
        actions: [
          IconButton(
            onPressed: () => ThemeNotifier.toggleTheme(),
            icon: (ThemeNotifier.themeNotifier.value == AppStyle.lightMode)
                ? Icon(Icons.light_mode_outlined)
                : Icon(Icons.dark_mode_outlined),
            color: theme.inverseSurface,
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  style: AppStyle.regular.copyWith(color: theme.inverseSurface),
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: AppStyle.regular.copyWith(color: theme.tertiary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: theme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: theme.primary, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  style: AppStyle.regular.copyWith(color: theme.inverseSurface),
                  obscureText: showPass,
                  controller: passwordContoller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      icon: showPass
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      color: theme.secondary,
                    ),
                    hintText: "Password",
                    hintStyle: AppStyle.regular.copyWith(color: theme.tertiary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: theme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: theme.primary, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: login,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 16.0,
                      ),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: AppStyle.bold.copyWith(color: theme.surface),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
