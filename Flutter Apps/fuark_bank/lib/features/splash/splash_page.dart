import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_routes.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';
import 'package:fuark_bank/features/splash/splash_controller.dart';
import 'package:fuark_bank/features/splash/splash_state.dart';
import 'package:fuark_bank/locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = locator.get<SplashController>();

  @override
  void initState() {
    super.initState();
    _splashController.isUserLogged();
    _splashController.addListener(() {
      if(_splashController.state is SplashSuccessState){
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }else{
        Navigator.pushReplacementNamed(context, AppRoutes.initial);
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
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
