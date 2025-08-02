import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/card/card_decoration.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          _socialButtons.length,
          (index) => _buildSocialButton(context, _socialButtons[index], index),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    SocialButtonData buttonData,
    int index,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        right: index == _socialButtons.length - 1 ? 0 : 8.w,
      ),
      child: GestureDetector(
        onTap: buttonData.onPressed,
        child: Container(
          width: 60.w,
          height: 60.h,
          decoration: context.cardDecoration,
          child: Center(
            child: SizedBox(
              width: 20.w,
              height: 20.h,
              child: AppSvgWidget(path: buttonData.svgPath),
            ),
          ),
        ),
      ),
    );
  }

  static const List<SocialButtonData> _socialButtons = [
    SocialButtonData(svgPath: AppSvg.google, onPressed: _handleGoogleLogin),
    SocialButtonData(svgPath: AppSvg.apple, onPressed: _handleAppleLogin),
    SocialButtonData(svgPath: AppSvg.facebook, onPressed: _handleFacebookLogin),
  ];

  static void _handleGoogleLogin() {
    // Google login logic
  }

  static void _handleAppleLogin() {
    // Apple login logic
  }

  static void _handleFacebookLogin() {
    // Facebook login logic
  }
}

class SocialButtonData {
  final String svgPath;
  final VoidCallback onPressed;

  const SocialButtonData({required this.svgPath, required this.onPressed});
}
