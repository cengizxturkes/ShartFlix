import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

class AppThemes {
  static const _font = 'app.dart';

  bool isDarkMode;
  Brightness brightness;
  Color primaryColor;
  Color secondaryColor;

  AppThemes({
    this.isDarkMode = false,
    this.primaryColor = AppColors.primary,
    this.secondaryColor = AppColors.secondary,
  }) : brightness = isDarkMode ? Brightness.dark : Brightness.light;

  Color get backgroundColor => AppColors.background;

  TextTheme get textTheme {
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final base = Typography.englishLike2018;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 96.sp,
        color: textColor,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 60.sp,
        color: textColor,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 48.sp,
        color: textColor,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 34.sp,
        color: textColor,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: 24.sp,
        color: textColor,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 20.sp,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 16.sp,
        color: textColor,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: 14.sp,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 16.sp, color: textColor),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 14.sp, color: textColor),
      bodySmall: base.bodySmall?.copyWith(fontSize: 12.sp, color: textColor),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 14.sp,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: base.labelSmall?.copyWith(fontSize: 14.sp, color: textColor),
    );
  }

  ///Light theme
  ThemeData get theme {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      fontFamily: _font,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        color: backgroundColor,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        titleTextStyle:
            isDarkMode
                ? const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )
                : const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: isDarkMode ? Colors.white : Colors.black,
        labelColor: Colors.white,
      ),
      iconTheme: IconThemeData(color: secondaryColor),
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(color: Colors.grey),
    );
  }
}
