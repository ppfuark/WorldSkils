import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';

class AppInput extends StatefulWidget {
  final String label;
  final String placeholder;
  const AppInput({super.key, required this.label, required this.placeholder});

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        border:OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
