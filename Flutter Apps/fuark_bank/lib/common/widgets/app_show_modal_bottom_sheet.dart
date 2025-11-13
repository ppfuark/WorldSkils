import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_colors.dart';
import 'package:fuark_bank/common/constants/app_text_style.dart';
import 'package:fuark_bank/common/widgets/app_button.dart';

void customShowModalBottomSheet(
  BuildContext context,
  String content,
  String buttomText,
) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(color: AppColors.black, border: Border.all()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Text(
                content,
                style: AppTextStyle.headline.copyWith(color: AppColors.white),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: AppButton(
                label: buttomText,
                isPrimary: false,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    },
  );
}
