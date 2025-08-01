import 'package:flutter/material.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

class AppSwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const AppSwitchWidget({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? AppColors.error,
      inactiveThumbColor: AppColors.white,
      inactiveTrackColor: inactiveColor ?? AppColors.gray3,
    );
  }
}
