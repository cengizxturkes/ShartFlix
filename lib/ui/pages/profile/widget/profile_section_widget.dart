import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class ProfileSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingNormal,
            vertical: AppDimens.paddingSmall,
          ),
          child: Text(
            title,
            style: AppTextStyle.whiteS20Bold.copyWith(fontSize: 20.sp),
          ),
        ),
        const SizedBox(height: AppDimens.marginNormal),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginNormal,
          ),
          decoration: BoxDecoration(
            color: AppColors.profileCardBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.profileCardBackground.withValues(alpha: 0.2),
            ),
          ),
          child: Column(children: children),
        ),
        const SizedBox(height: AppDimens.marginNormal),
      ],
    );
  }
}
