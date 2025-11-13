import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';
import 'package:fuark_bank/common/widgets/app_button.dart';
import 'package:fuark_bank/features/sign_up/sign_up_page.dart';
import 'package:fuark_bank/features/splash/splash_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.grayBlackGradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: 0,
              bottom: 60,
              left: 40,
              right: 40,
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset("assets/images/man_on_pig_get_stated.png"),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Save your ",
                            style: AppTextStyle.bigText.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            "Cash",
                            style: AppTextStyle.bigText.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          AppButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            label: "Get Stated",
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have account? ",
                                style: AppTextStyle.headline.copyWith(
                                  color: AppColors.tertiary,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SplashPage(),
                                    ),
                                  ),
                                },
                                child: Text(
                                  "Sing In",
                                  style: AppTextStyle.headline.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
