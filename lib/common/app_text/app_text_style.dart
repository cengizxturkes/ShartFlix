import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  // Base text styles with proper font family
  static const _baseTextStyle = TextStyle(
    fontFamily: 'EuclidCircularA',
    fontWeight: FontWeight.w400,
  );

  // Font weights that match the configured fonts
  static const _light = FontWeight.w300;
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  // Font sizes
  static double _s10 = 10.0.sp;
  static double _s12 = 12.0.sp;
  static double _s14 = 14.0.sp;
  static double _s15 = 15.0.sp;
  static double _s16 = 16.0.sp;
  static double _s18 = 18.0.sp;
  static double _s20 = 20.0.sp;
  static double _s24 = 24.0.sp;
  static double _s28 = 28.0.sp;
  static double _s32 = 32.0.sp;

  // Helper method to create text styles
  static TextStyle _createStyle({
    required Color color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  // Default white text style for buttons (16px, regular weight)
  static const white = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'EuclidCircularA',
  );

  // ===== BLACK TEXT STYLES =====

  // Light variants
  static final blackS12Light = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s12,
    fontWeight: _light,
  );
  static final blackS14Light = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s14,
    fontWeight: _light,
  );
  static final blackS16Light = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s16,
    fontWeight: _light,
  );
  static final blackS18Light = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s18,
    fontWeight: _light,
  );

  // Regular variants
  static final blackS10 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s10,
    fontWeight: _regular,
  );
  static final blackS12 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s12,
    fontWeight: _regular,
  );
  static final blackS14 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s14,
    fontWeight: _regular,
  );
  static final blackS16 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s16,
    fontWeight: _regular,
  );
  static final blackS18 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s18,
    fontWeight: _regular,
  );
  static final blackS20 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s20,
    fontWeight: _regular,
  );
  static final blackS24 = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s24,
    fontWeight: _regular,
  );

  // Medium variants
  static final blackS10Medium = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s10,
    fontWeight: _medium,
  );
  static final blackS12Medium = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s12,
    fontWeight: _medium,
  );
  static final blackS14Medium = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s14,
    fontWeight: _medium,
  );
  static final blackS16Medium = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s16,
    fontWeight: _medium,
  );
  static final blackS18Medium = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s18,
    fontWeight: _medium,
  );

  // SemiBold variants
  static final blackS12SemiBold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s12,
    fontWeight: _semiBold,
  );
  static final blackS14SemiBold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s14,
    fontWeight: _semiBold,
  );
  static final blackS16SemiBold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s16,
    fontWeight: _semiBold,
  );
  static final blackS18SemiBold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s18,
    fontWeight: _semiBold,
  );
  static final blackS20SemiBold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s20,
    fontWeight: _semiBold,
  );
  static final blackS24SemiBold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s24,
    fontWeight: _semiBold,
  );

  // Bold variants
  static final blackS10Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s10,
    fontWeight: _bold,
  );
  static final blackS12Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s12,
    fontWeight: _bold,
  );
  static final blackS14Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s14,
    fontWeight: _bold,
  );
  static final blackS16Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s16,
    fontWeight: _bold,
  );
  static final blackS18Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s18,
    fontWeight: _bold,
  );
  static final blackS20Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s20,
    fontWeight: _bold,
  );
  static final blackS24Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s24,
    fontWeight: _bold,
  );
  static final blackS28Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s28,
    fontWeight: _bold,
  );
  static final blackS32Bold = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s32,
    fontWeight: _bold,
  );

  // Italic variants
  static final blackS12Italic = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s12,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final blackS14Italic = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s14,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final blackS16Italic = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s16,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final blackS18Italic = _createStyle(
    color: AppColors.textBlack,
    fontSize: _s18,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );

  // ===== BLUE TEXT STYLES =====

  // Regular variants
  static final blueS12 = _createStyle(
    color: AppColors.secondary,
    fontSize: _s12,
    fontWeight: _regular,
  );
  static final blueS14 = _createStyle(
    color: AppColors.secondary,
    fontSize: _s14,
    fontWeight: _regular,
  );
  static final blueS16 = _createStyle(
    color: AppColors.secondary,
    fontSize: _s16,
    fontWeight: _regular,
  );
  static final blueS18 = _createStyle(
    color: AppColors.secondary,
    fontSize: _s18,
    fontWeight: _regular,
  );

  // Medium variants
  static final blueS12Medium = _createStyle(
    color: AppColors.secondary,
    fontSize: _s12,
    fontWeight: _medium,
  );
  static final blueS14Medium = _createStyle(
    color: AppColors.secondary,
    fontSize: _s14,
    fontWeight: _medium,
  );
  static final blueS16Medium = _createStyle(
    color: AppColors.secondary,
    fontSize: _s16,
    fontWeight: _medium,
  );

  // SemiBold variants
  static final blueS12SemiBold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s12,
    fontWeight: _semiBold,
  );
  static final blueS14SemiBold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s14,
    fontWeight: _semiBold,
  );
  static final blueS16SemiBold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s16,
    fontWeight: _semiBold,
  );
  static final blueS18SemiBold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s18,
    fontWeight: _semiBold,
  );

  // Bold variants
  static final blueS12Bold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s12,
    fontWeight: _bold,
  );
  static final blueS14Bold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s14,
    fontWeight: _bold,
  );
  static final blueS16Bold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s16,
    fontWeight: _bold,
  );
  static final blueS18Bold = _createStyle(
    color: AppColors.secondary,
    fontSize: _s18,
    fontWeight: _bold,
  );

  // Italic variants
  static final blueS12Italic = _createStyle(
    color: AppColors.secondary,
    fontSize: _s12,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final blueS14Italic = _createStyle(
    color: AppColors.secondary,
    fontSize: _s14,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final blueS16Italic = _createStyle(
    color: AppColors.secondary,
    fontSize: _s16,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );

  // ===== WHITE TEXT STYLES =====

  // Regular variants
  static final whiteS12 = _createStyle(color: Colors.white, fontSize: _s12);
  static final whiteS14 = _createStyle(color: Colors.white, fontSize: _s14);
  static final whiteS16 = _createStyle(color: Colors.white, fontSize: _s16);
  static final whiteS18 = _createStyle(color: Colors.white, fontSize: _s18);
  static final whiteS20 = _createStyle(color: Colors.white, fontSize: _s20);
  static final whiteS24 = _createStyle(color: Colors.white, fontSize: _s24);

  // Light variants
  static final whiteS12Light = _createStyle(
    color: Colors.white,
    fontSize: _s12,
    fontWeight: _light,
  );
  static final whiteS14Light = _createStyle(
    color: Colors.white,
    fontSize: _s14,
    fontWeight: _light,
  );
  static final whiteS16Light = _createStyle(
    color: Colors.white,
    fontSize: _s16,
    fontWeight: _light,
  );

  // Medium variants
  static final whiteS12Medium = _createStyle(
    color: Colors.white,
    fontSize: _s12,
    fontWeight: _medium,
  );
  static final whiteS12Regular = _createStyle(
    color: Colors.white,
    fontSize: _s12,
    fontWeight: _regular,
  );
  static final whiteS14Medium = _createStyle(
    color: Colors.white,
    fontSize: _s14,
    fontWeight: _medium,
  );
  static final whiteS15Regular = _createStyle(
    color: Colors.white,
    fontSize: _s15,
    fontWeight: _regular,
  );
  static final whiteS16Medium = _createStyle(
    color: Colors.white,
    fontSize: _s16,
    fontWeight: _medium,
  );

  // SemiBold variants
  static final whiteS12SemiBold = _createStyle(
    color: Colors.white,
    fontSize: _s12,
    fontWeight: _semiBold,
  );
  static final whiteS14SemiBold = _createStyle(
    color: Colors.white,
    fontSize: _s14,
    fontWeight: _semiBold,
  );
  static final whiteS16SemiBold = _createStyle(
    color: Colors.white,
    fontSize: _s16,
    fontWeight: _semiBold,
  );
  static final whiteS18SemiBold = _createStyle(
    color: Colors.white,
    fontSize: _s18,
    fontWeight: _semiBold,
  );
  static final whiteS20SemiBold = _createStyle(
    color: Colors.white,
    fontSize: _s20,
    fontWeight: _semiBold,
  );

  // Bold variants
  static final whiteS12Bold = _createStyle(
    color: Colors.white,
    fontSize: _s12,
    fontWeight: _bold,
  );
  static final whiteS14Bold = _createStyle(
    color: Colors.white,
    fontSize: _s14,
    fontWeight: _bold,
  );
  static final whiteS16Bold = _createStyle(
    color: Colors.white,
    fontSize: _s16,
    fontWeight: _bold,
  );
  static final whiteS18Bold = _createStyle(
    color: Colors.white,
    fontSize: _s18,
    fontWeight: _bold,
  );
  static final whiteS20Bold = _createStyle(
    color: Colors.white,
    fontSize: _s20,
    fontWeight: _bold,
  );
  static final whiteS24Bold = _createStyle(
    color: Colors.white,
    fontSize: _s24,
    fontWeight: _bold,
  );

  // Italic variants
  static final whiteS12Italic = _createStyle(
    color: Colors.white,
    fontSize: _s12,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final whiteS14Italic = _createStyle(
    color: Colors.white,
    fontSize: _s14,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final whiteS16Italic = _createStyle(
    color: Colors.white,
    fontSize: _s16,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );

  // ===== GRAY TEXT STYLES =====

  // Regular variants
  static final grayS10 = _createStyle(
    color: AppColors.textGray,
    fontSize: _s10,
    fontWeight: _regular,
  );
  static final grayS12 = _createStyle(
    color: AppColors.textGray,
    fontSize: _s12,
    fontWeight: _regular,
  );
  static final grayS14 = _createStyle(
    color: AppColors.textGray,
    fontSize: _s14,
    fontWeight: _regular,
  );
  static final grayS16 = _createStyle(
    color: AppColors.textGray,
    fontSize: _s16,
    fontWeight: _regular,
  );
  static final grayS18 = _createStyle(
    color: AppColors.textGray,
    fontSize: _s18,
    fontWeight: _regular,
  );

  // Light variants
  static final grayS10Light = _createStyle(
    color: AppColors.textGray,
    fontSize: _s10,
    fontWeight: _light,
  );
  static final grayS12Light = _createStyle(
    color: AppColors.textGray,
    fontSize: _s12,
    fontWeight: _light,
  );
  static final grayS14Light = _createStyle(
    color: AppColors.textGray,
    fontSize: _s14,
    fontWeight: _light,
  );

  // Medium variants
  static final grayS10Medium = _createStyle(
    color: AppColors.textGray,
    fontSize: _s10,
    fontWeight: _medium,
  );
  static final grayS12Medium = _createStyle(
    color: AppColors.textGray,
    fontSize: _s12,
    fontWeight: _medium,
  );
  static final grayS14Medium = _createStyle(
    color: AppColors.textGray,
    fontSize: _s14,
    fontWeight: _medium,
  );
  static final grayS16Medium = _createStyle(
    color: AppColors.textGray,
    fontSize: _s16,
    fontWeight: _medium,
  );

  // SemiBold variants
  static final grayS12SemiBold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s12,
    fontWeight: _semiBold,
  );
  static final grayS14SemiBold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s14,
    fontWeight: _semiBold,
  );
  static final grayS16SemiBold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s16,
    fontWeight: _semiBold,
  );

  // Bold variants
  static final grayS10Bold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s10,
    fontWeight: _bold,
  );
  static final grayS12Bold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s12,
    fontWeight: _bold,
  );
  static final grayS14Bold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s14,
    fontWeight: _bold,
  );
  static final grayS16Bold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s16,
    fontWeight: _bold,
  );
  static final grayS18Bold = _createStyle(
    color: AppColors.textGray,
    fontSize: _s18,
    fontWeight: _bold,
  );

  // Italic variants
  static final grayS10Italic = _createStyle(
    color: AppColors.textGray,
    fontSize: _s10,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final grayS12Italic = _createStyle(
    color: AppColors.textGray,
    fontSize: _s12,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
  static final grayS14Italic = _createStyle(
    color: AppColors.textGray,
    fontSize: _s14,
    fontWeight: _regular,
    fontStyle: FontStyle.italic,
  );
}
