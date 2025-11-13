import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_routes.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Timer init(){
    return Timer(Duration(seconds: 2), navigateToOnboarding);
  }

  void navigateToOnboarding(){
    Navigator.pushReplacementNamed(context, AppRoutes.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.grayBlackGradiant,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "fuark",
              style: AppTextStyle.splashScreenText.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            CircularProgressIndicator(color: AppColors.primaryColor,)
          ],
        ),
      ),
    );
  }
}
