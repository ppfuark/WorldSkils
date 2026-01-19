import 'package:flutter/material.dart';
import 'package:yt_auth_app/common/models/user_model.dart';
import 'package:yt_auth_app/common/widgets/app_brand_button.dart';
import 'package:yt_auth_app/common/widgets/app_button.dart';
import 'package:yt_auth_app/common/widgets/app_textfield.dart';
import 'package:yt_auth_app/features/home/home.dart';
import 'package:yt_auth_app/services/auth/firebase_auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  late Future<UserModel> request;

  void signUserIn() async {
  try {
    final user = await _firebaseAuthService.signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Home()),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Icon(Icons.lock, size: 100),
              SizedBox(height: 50),
              Text("Welcome back your've been missed!"),
              SizedBox(height: 25),
              AppTextfield(
                controller: emailController,
                obscureText: false,
                hintText: "email",
              ),
              SizedBox(height: 25),
              AppTextfield(
                controller: passwordController,
                obscureText: true,
                hintText: "Password",
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              AppButton(onTap: signUserIn),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBrandButton(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 25),
                  AppBrandButton(imagePath: 'lib/images/apple.png'),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Register Now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
