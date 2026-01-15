// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fuark_bank/common/widgets/app_input.dart';

class AppPasswordInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final String? helperText;

  const AppPasswordInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.textCapitalization,
    this.textEditingController,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.validator,
    this.helperText,
  });

  @override
  State<AppPasswordInput> createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return AppInput(
      helperText: widget.helperText,
      validator: widget.validator,
      obscureText: isHidden,
      textEditingController: widget.textEditingController,
      label: widget.label,
      placeholder: widget.placeholder,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(23.0),
        child: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        onTap: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
      ),
    );
  }
}
