import 'package:flutter/material.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

class AppShadow {
  AppShadow._();

  static final defaultShadow = [
    const BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
  ];
  static final homePageFeaturedMovieShadow = [
    const BoxShadow(
      color: AppColors.shadow,
      blurRadius: 10,
      offset: Offset(0, 10),
    ),
  ];
  static final appBarShadow = [
    const BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
}
