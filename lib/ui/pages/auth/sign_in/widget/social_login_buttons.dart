import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/card/card_decoration.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/sign_up_cubit.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          _socialButtons(context).length,
          (index) => _buildSocialButton(context, _socialButtons(context)[index], index),
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
        right: index == _socialButtons(context).length - 1 ? 0 : 8.w,
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

  static List<SocialButtonData> _socialButtons(BuildContext context) => [
    SocialButtonData(svgPath: AppSvg.google, onPressed: () => _handleGoogleLogin(context)),
    SocialButtonData(svgPath: AppSvg.apple, onPressed: () => _handleAppleLogin(context)),
    SocialButtonData(svgPath: AppSvg.facebook, onPressed: () => _handleFacebookLogin(context)),
  ];

  static void _handleGoogleLogin(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();
    signUpCubit.signInWithGoogle();
  }

  static void _handleAppleLogin(BuildContext context) {
    // Apple login logic - to be implemented
  }

  static void _handleFacebookLogin(BuildContext context) {
    // Facebook login logic - to be implemented
  }
}

class SocialButtonData {
  final String svgPath;
  final VoidCallback onPressed;

  const SocialButtonData({required this.svgPath, required this.onPressed});
}
