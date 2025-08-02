import 'package:flutter/material.dart';

import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hesabın yok mu?",
          style: AppTextStyle.whiteS12Regular.copyWith(
            color: AppColors.white.withValues(alpha: 0.5),
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to register page
          },
          child: Text(
            "Kayıt ol",
            style: AppTextStyle.whiteS12Regular.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
