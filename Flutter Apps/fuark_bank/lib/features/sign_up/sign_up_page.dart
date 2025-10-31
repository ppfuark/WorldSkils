import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';
import 'package:fuark_bank/common/utils/uppercase_text_formater.dart';
import 'package:fuark_bank/common/widgets/app_button.dart';
import 'package:fuark_bank/common/widgets/app_input.dart';
import 'package:fuark_bank/common/widgets/app_password_input.dart';
import 'package:fuark_bank/features/splash/splash_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: AppColors.grayBlackGradiant,
          //   begin: AlignmentGeometry.topCenter,
          // ),
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Saving Your",
                          style: AppTextStyle.h1.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "Money!",
                          style: AppTextStyle.h1.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 30,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppInput(
                            label: "Your name",
                            placeholder: "John Doe",
                            inputFormatters: [UppercaseTextFormater()],
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "This field can not be empty!";
                              }
                              return null;
                            },
                          ),
                          AppInput(
                            label: "Your email",
                            placeholder: "youremail@example.com",
                          ),
                          AppPasswordInput(
                            placeholder: "Password",
                            label: "Choose your password",
                          ),
                          AppPasswordInput(
                            placeholder: "Password",
                            label: "Confirm your password",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        onPressed: () {
                          final valid = _formKey.currentState?.validate();
                          log(valid.toString());
                        },
                        label: "Sign Up",
                      ),
                      SizedBox(height: 15),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
