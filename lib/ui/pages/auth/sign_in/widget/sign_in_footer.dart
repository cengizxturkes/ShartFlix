import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/router/route_config.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bir hesabın yok mu?",
          style: AppTextStyle.whiteS12Regular.copyWith(
            color: AppColors.white.withValues(alpha: 0.5),
          ),
        ),
        TextButton(
          onPressed: () {
            context.go(AppRouter.signUp);
          },
          child: Text(
            "Kayıt ol!",
            style: AppTextStyle.whiteS12Regular.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
