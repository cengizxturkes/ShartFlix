import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "appStartText".tr(),
          style: AppTextStyle.whiteS18SemiBold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Text(
            "Sizi yeniden görmek çok güzel!",
            style: AppTextStyle.whiteS12.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
