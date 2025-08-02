import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        const SizedBox(height: AppDimens.marginSmall),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginNormal,
          ),

          child: Column(children: children),
        ),
        const SizedBox(height: AppDimens.marginNormal),
      ],
    );
  }
}
