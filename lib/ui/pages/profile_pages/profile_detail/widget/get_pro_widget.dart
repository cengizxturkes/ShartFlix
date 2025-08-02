import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class GetProWidget extends StatelessWidget {
  final VoidCallback onTap;
  const GetProWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 112.w,
        height: 33.h,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(53.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Row(
          children: [
            AppSvgWidget(path: AppSvg.pro, width: 18.w, height: 18.h),
            Text('Sınırlı Teklif', style: AppTextStyle.whiteS12Bold),
          ],
        ),
      ),
    );
  }
}
