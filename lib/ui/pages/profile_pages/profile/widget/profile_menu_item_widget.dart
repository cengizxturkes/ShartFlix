import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/common/card/card_decoration.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: context.cardDecorationWithoutBorder,
        margin: EdgeInsets.symmetric(vertical: AppDimens.marginSmall / 4),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.paddingNormal,
          vertical: AppDimens.paddingSmall,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.profileCardBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: AppColors.white, size: 20),
            ),
            const SizedBox(width: AppDimens.marginNormal),
            Expanded(child: Text(title, style: AppTextStyle.whiteS16Medium)),
            if (trailing != null) trailing!,
            if (showArrow && trailing == null)
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textGray,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
