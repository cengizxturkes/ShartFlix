import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color focusedColor;
  final EdgeInsets? padding;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool enable;
  final bool obscureText;
  final VoidCallback? onSuffixIconTap;

  const AppTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.style,
    this.focusedColor = AppColors.secondary,
    this.padding,
    this.errorStyle,
    this.validator,
    this.keyboardType,
    this.inputFormatters = const [],
    this.enable = true,
    this.obscureText = false,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      style:
          style ??
          AppTextStyle.whiteS14.copyWith(
            fontSize: 12,
            height: 1.5, // line-height = fontSize * height = 12*1.5 = 18
          ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          minWidth: 17.67.w,
          minHeight: 15.73.h,
          maxHeight: 35.h,
          maxWidth: 35.w,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 17.67.w,
          minHeight: 15.73.h,
          maxHeight: 35.h,
          maxWidth: 35.w,
        ),
        filled: true,
        fillColor: enable ? Colors.transparent : AppColors.inputDisabled,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.grayS12.copyWith(height: 1.5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: focusedColor, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.inputBorder, width: 1.w),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.inputBorder, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.error, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.error, width: 1.w),
        ),
        errorStyle:
            errorStyle ??
            AppTextStyle.blackS12.copyWith(color: AppColors.error),
        prefixIcon: prefixIcon,
        suffixIcon:
            suffixIcon != null
                ? GestureDetector(onTap: onSuffixIconTap, child: suffixIcon)
                : null,
      ),
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      enabled: enable,
      obscureText: obscureText,
    );
  }
}
