import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/widgets/app_text_field/app_text_field.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';
import 'package:my_app/common/app_images/app_svg.dart';

class SignInForm extends StatefulWidget {
  final SignInCubit cubit;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const SignInForm({
    super.key,
    required this.cubit,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildEmailField(),
          SizedBox(height: 8.h),
          _buildPasswordField(),
          SizedBox(height: 29.h),
          _buildForgotPasswordButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return AppTextField(
      onChanged: (value) {
        widget.cubit.changeEmail(email: value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email boş olamaz";
        }
        if (!Utils.isEmail(value)) {
          return "Geçersiz email";
        }
        return null;
      },
      controller: widget.emailController,
      hintText: "Email",
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 3.w),
        child: AppSvgWidget(path: AppSvg.message, width: 20.w, height: 20.h),
      ),
    );
  }

  Widget _buildPasswordField() {
    return AppTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Şifre boş olamaz";
        }
        return null;
      },
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 3.w),
        child: AppSvgWidget(path: AppSvg.unlock, width: 20.w, height: 20.h),
      ),
      onChanged: (value) {
        widget.cubit.changePassword(password: value);
      },
      obscureText: isPasswordVisible,
      onSuffixIconTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      suffixIcon: Padding(
        padding: EdgeInsets.only(left: 3.w, right: 10.w),
        child: AppSvgWidget(
          path: isPasswordVisible ? AppSvg.eye_show : AppSvg.eye_hide,
          width: 20.w,
          height: 20.h,
        ),
      ),
      controller: widget.passwordController,
      hintText: "Şifre",
    );
  }

  Widget _buildForgotPasswordButton() {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Şifremi unuttum",
            style: AppTextStyle.whiteS12Regular.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
