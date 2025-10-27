import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
        child: Text(
          "fuark",
          style: AppTextStyle.splashScreenText.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
