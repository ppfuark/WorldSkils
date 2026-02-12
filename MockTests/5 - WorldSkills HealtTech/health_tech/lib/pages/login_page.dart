import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_tech/app_style.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var showPass = false;
  var iconPass = Icon(Icons.visibility_outlined);

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final response = await http.get(
        Uri.parse(
          "http://10.109.66.116:3000/usuarios?email=${emailController.text}&senha=${passwordController.text}",
        ),
      );

      final List users = jsonDecode(response.body);
      if (mounted) {
        if (users.isNotEmpty) {
          Navigator.pushNamed(context, "/management_animal");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro no login. Verfique suas credencias."),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Animais")),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/ws.png'),
                    SizedBox(height: 20),
                    Text("Uma nova forma de", style: AppStyle.bold),
                    Text("cuidar de sua fazenda!", style: AppStyle.bold),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF00A3E0),
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xFF00A3E0),
                        ),
                        hintText: "Email",
                        hintStyle: AppStyle.regular.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00A3E0)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF00A3E0),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00A3E0)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: !showPass,
                      controller: passwordController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF00A3E0),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;

                              if (!showPass) {
                                iconPass = Icon(Icons.visibility_outlined);
                              } else {
                                iconPass = Icon(Icons.visibility_off_outlined);
                              }
                            });
                          },
                          icon: iconPass,
                          color: Color(0xFF00A3E0),
                        ),
                        hintText: "Password",
                        hintStyle: AppStyle.regular.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00A3E0)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF00A3E0),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00A3E0)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: login,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Color(0xFF4169E1),
                        ),
                        child: Center(
                          child: Text(
                            'Logar',
                            style: AppStyle.bold.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register_animal');
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text('Cadastre seu animal', style: AppStyle.bold),
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
