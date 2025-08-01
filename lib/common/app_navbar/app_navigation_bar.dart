import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70.h,
        width: double.infinity,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NavItem(
              icon: AppSvgWidget(
                path: AppSvg.home,
                color: AppColors.white,
                height: 28.h,
                width: 28.w,
              ),
              label: "Anasayfa",
              selected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            SizedBox(width: 16.w),
            _NavItem(
              icon: AppSvgWidget(
                path: AppSvg.search,
                color: AppColors.white,
                height: 28.h,
                width: 28.w,
              ),
              label: "Profil",
              selected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: AppColors.background.withValues(alpha: 0.2),
      highlightColor: AppColors.background.withValues(alpha: 0.2),
      splashColor: AppColors.background.withValues(alpha: 0.2),
      hoverColor: AppColors.background.withValues(alpha: 0.2),
      child: Container(
        width: 125.w,
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.2),
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(label, style: AppTextStyle.whiteS12Medium),
          ],
        ),
      ),
    );
  }
}
