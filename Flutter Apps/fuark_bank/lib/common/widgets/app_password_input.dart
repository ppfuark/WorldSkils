import 'dart:developer';

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

  const AppPasswordInput({
    super.key,
    required this.placeholder,
    required this.label,
    this.keyboardType,
    this.maxLength,
    this.textCapitalization,
    this.textEditingController,
    this.textInputAction,
  });

  @override
  State<AppPasswordInput> createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return AppInput(
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
          log("AFFF");
          setState(() {
            isHidden = !isHidden;
          });
        },
      ),
    );
  }
}
