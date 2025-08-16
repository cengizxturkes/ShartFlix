import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/card/card_decoration.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final VoidCallback? onFacebookPressed;

  const SocialLoginButtons({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.onFacebookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          _getSocialButtons().length,
          (index) => _buildSocialButton(context, _getSocialButtons()[index], index),
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
        right: index == _getSocialButtons().length - 1 ? 0 : 8.w,
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

  List<SocialButtonData> _getSocialButtons() => [
    SocialButtonData(svgPath: AppSvg.google, onPressed: onGooglePressed ?? _handleGoogleLogin),
    SocialButtonData(svgPath: AppSvg.apple, onPressed: onApplePressed ?? _handleAppleLogin),
    SocialButtonData(svgPath: AppSvg.facebook, onPressed: onFacebookPressed ?? _handleFacebookLogin),
  ];

  static void _handleGoogleLogin() {
    // Default Google login logic (empty)
  }

  static void _handleAppleLogin() {
    // Default Apple login logic (empty)
  }

  static void _handleFacebookLogin() {
    // Default Facebook login logic (empty)
  }
}

class SocialButtonData {
  final String svgPath;
  final VoidCallback onPressed;

  const SocialButtonData({required this.svgPath, required this.onPressed});
}
