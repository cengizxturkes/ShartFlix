import 'package:flutter/material.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

extension CardDecoration on BuildContext {
  BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white.withValues(alpha: 0.1),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
  );
}

extension CardDecorationWithoutBorder on BuildContext {
  BoxDecoration get cardDecorationWithoutBorder => BoxDecoration(
    color: Color(0xFF1C1D1F).withValues(alpha: 0.5),
    borderRadius: BorderRadius.circular(12),
  );
}

extension CardDecorationWithoutBorderWithSelected on BuildContext {
  BoxDecoration get cardDecorationWithoutBorderWithSelected => BoxDecoration(
    color: AppColors.primary.withValues(alpha: 0.2),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.primary),
  );
}
