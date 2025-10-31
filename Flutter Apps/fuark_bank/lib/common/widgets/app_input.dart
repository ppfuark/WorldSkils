import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';

class AppInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool? obscureText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;

  const AppInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.maxLength,
    this.textCapitalization,
    this.textEditingController,
    this.textInputAction,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.headline.copyWith(color: AppColors.white),
      obscureText: widget.obscureText ?? false,
      controller: widget.textEditingController,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        // prefixIcon: Icon(Icons.add),
        hintText: widget.placeholder,
        hintStyle: AppTextStyle.headline.copyWith(color: AppColors.secoundary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.label.toUpperCase(),
        labelStyle: AppTextStyle.headline.copyWith(color: AppColors.secoundary),
        focusedBorder: defaultBorder,
        errorBorder: defaultBorder,
        focusedErrorBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
      ),
    );
  }
}
