import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_routes.dart';
import 'package:fuark_bank/common/constants/app_theme_data.dart';
import 'package:fuark_bank/features/home/home_page.dart';
import 'package:fuark_bank/features/onboarding/onboarding_page.dart';
import 'package:fuark_bank/features/sign_up/sign_up_page.dart';
import 'package:fuark_bank/features/sing_in/sign_in_page.dart';
import 'package:fuark_bank/features/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.initial: (context) => const OnboardingPage(),
        AppRoutes.signUp: (context) => const SignUpPage(),
        AppRoutes.signIn: (context) => const SignInPage(),
        AppRoutes.splash: (context) => const SplashPage(),
        AppRoutes.home: (context) => const HomePage(),
      },
    );
  }
}
