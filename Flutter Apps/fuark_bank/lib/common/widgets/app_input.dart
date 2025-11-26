import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? helperText;

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
    this.inputFormatters,
    this.validator,
    this.helperText,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  String? _helperText;

  @override
  void initState() {
    super.initState();
    _helperText = widget.helperText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (value.length == 1) {
          setState(() {
            _helperText = null;
          });
        } else if (value.isEmpty) {
          setState(() {
            _helperText = widget.helperText;
          });
        }
      },
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      style: AppTextStyle.headline.copyWith(color: AppColors.white),
      obscureText: widget.obscureText ?? false,
      controller: widget.textEditingController,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        helperText: _helperText,
        helperStyle: TextStyle(color: AppColors.tertiary),
        helperMaxLines: 3,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: AppColors.primaryColor,
        // prefixIcon: Icon(Icons.add),
        hintText: widget.placeholder,
        hintStyle: AppTextStyle.headline.copyWith(color: AppColors.secoundary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.label.toUpperCase(),
        labelStyle: AppTextStyle.headline.copyWith(color: AppColors.tertiary),
        focusedBorder: defaultBorder,
        errorBorder: defaultBorder,
        errorStyle: TextStyle(color: AppColors.primaryColor),
        focusedErrorBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
      ),
    );
  }
}
