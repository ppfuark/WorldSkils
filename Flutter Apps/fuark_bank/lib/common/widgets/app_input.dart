import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';

class AppInput extends StatefulWidget {
  final String label;
  final String placeholder;
  const AppInput({super.key, required this.label, required this.placeholder});

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
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.add),
        hintText: widget.placeholder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.label.toUpperCase(),
        labelStyle: AppTextStyle.headline,
        focusedBorder: defaultBorder,
        errorBorder: defaultBorder,
        focusedErrorBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
      ),
    );
  }
}
