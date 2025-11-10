import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isPrimary;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.orangesGradiant,
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            width: 400,
            height: 64,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.transparent,
                ),
                shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
              ),
              child: Text(
                label,
                style: AppTextStyle.h1.copyWith(color: AppColors.white),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.primaryColor, width: 3.0),
            ),
            width: double.infinity,
            height: 64,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.transparent,
                ),
                shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
              ),
              child: Text(
                label,
                style: AppTextStyle.h1.copyWith(color: AppColors.primaryColor),
              ),
            ),
          );
  }
}
