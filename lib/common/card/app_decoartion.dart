import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

// Movie Detail Page Decorations
extension MovieDetailDecorations on BuildContext {
  // Gradient overlay for movie images
  BoxDecoration get movieImageGradient => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.black.withValues(alpha: 0.3),
        Colors.black.withValues(alpha: 0.8),
      ],
    ),
  );

  // Favorite button background
  BoxDecoration get favoriteButtonDecoration => BoxDecoration(
    color: Colors.black.withValues(alpha: 0.5),
    shape: BoxShape.circle,
  );

  // Genre chip decoration
  BoxDecoration get genreChipDecoration => BoxDecoration(
    color: Colors.grey.withValues(alpha: 0.2),
    borderRadius: BorderRadius.circular(20.r),
  );

  // Image indicator decoration
  BoxDecoration get imageIndicatorDecoration => BoxDecoration(
    color: AppColors.buttonColor,
    borderRadius: BorderRadius.circular(4.r),
  );

  // Inactive image indicator decoration
  BoxDecoration get inactiveImageIndicatorDecoration => BoxDecoration(
    color: Colors.white.withValues(alpha: 0.5),
    borderRadius: BorderRadius.circular(4.r),
  );
}
