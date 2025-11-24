import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_routes.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';
import 'package:fuark_bank/common/models/user_model.dart';
import 'package:fuark_bank/common/utils/uppercase_text_formater.dart';
import 'package:fuark_bank/common/widgets/app_button.dart';
import 'package:fuark_bank/common/widgets/app_input.dart';
import 'package:fuark_bank/common/widgets/app_password_input.dart';
import 'package:fuark_bank/common/widgets/app_show_modal_bottom_sheet.dart';
import 'package:fuark_bank/features/sign_up/sign_up_controller.dart';
import 'package:fuark_bank/features/sign_up/sign_up_state.dart';
import 'package:fuark_bank/common/utils/validator.dart';
import 'package:fuark_bank/locator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _controller = locator.get<SignUpController>();
  

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      log(_controller.state.toString());

      if (_controller.state is SignUpLoadingState) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        );
      }

      if (_controller.state is SignUpSuccessState) {
        // Navigate only after success
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                const Scaffold(body: Center(child: Text("New Page"))),
          ),
          (route) => false,
        );
      }

      if (_controller.state is SignUpErrorState) {
        final errorMessage = (_controller.state as SignUpErrorState).errorMessage;
        Navigator.pop(context);
        customShowModalBottomSheet(context, errorMessage, "Try again!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.only(
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
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppInput(
                            textEditingController: _nameController,
                            label: "Your name",
                            placeholder: "John Doe",
                            inputFormatters: [UppercaseTextFormater()],
                            validator: Validator.validateName,
                          ),
                          const SizedBox(height: 30),
                          AppInput(
                            textEditingController: _emailController,
                            label: "Your email",
                            placeholder: "youremail@example.com",
                            validator: Validator.validateEmail,
                          ),
                          const SizedBox(height: 30),
                          AppPasswordInput(
                            textEditingController: _passwordController,
                            placeholder: "Password",
                            label: "Choose your password",
                            helperText:
                                "Your password must be at least 8 characters, one uppercase letter, one number and one special character",
                            validator: Validator.validatePassword,
                          ),
                          const SizedBox(height: 30),
                          AppPasswordInput(
                            textEditingController: _confirmPasswordController,
                            placeholder: "Password",
                            label: "Confirm your password",
                            validator: (value) =>
                                Validator.validateConfirmPassword(
                                  _passwordController.text,
                                  value,
                                ),
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
                        isPrimary: true,
                        onPressed: () async {
                          // Fix validation logic
                          if (_formKey.currentState!.validate()) {
                            await _controller.doSignUp(
                              userData: UserModel(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        label: "Sign Up",
                      ),
                      const SizedBox(height: 15),
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
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.signIn,
                              );
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
