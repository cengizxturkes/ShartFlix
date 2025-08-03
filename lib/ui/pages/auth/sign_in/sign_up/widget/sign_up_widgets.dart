import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/sign_up_cubit.dart';
import 'package:my_app/widgets/app_text_field/app_text_field.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 138.h),
        Text("Hoşgeldiniz", style: AppTextStyle.whiteS24Bold),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Text(
            "Hemen kayıt ol ve film dünyasına katıl!",
            style: AppTextStyle.whiteS14.copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  final SignUpCubit cubit;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const SignUpForm({
    super.key,
    required this.cubit,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: widget.nameController,
            hintText: "Ad Soyad",
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 3.w),
              child: AppSvgWidget(
                path: AppSvg.add_user,
                width: 20.w,
                height: 20.h,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ad alanı zorunludur';
              }
              return null;
            },
          ),
          SizedBox(height: 13.h),
          AppTextField(
            controller: widget.emailController,
            hintText: "E-posta",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 3.w),
              child: AppSvgWidget(
                path: AppSvg.message,
                width: 20.w,
                height: 20.h,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-posta alanı zorunludur';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Geçerli bir e-posta adresi giriniz';
              }
              return null;
            },
          ),
          SizedBox(height: 13.h),
          AppTextField(
            controller: widget.passwordController,
            hintText: "Şifre",
            obscureText: isPasswordVisible,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 3.w),
              child: AppSvgWidget(
                path: AppSvg.unlock,
                width: 20.w,
                height: 20.h,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Şifre alanı zorunludur';
              }
              if (value.length < 6) {
                return 'Şifre en az 6 karakter olmalıdır';
              }
              return null;
            },
          ),
          SizedBox(height: 13.h),
          AppTextField(
            controller: widget.confirmPasswordController,
            hintText: "Şifre Tekrar",
            obscureText: isConfirmPasswordVisible,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 3.w),
              child: AppSvgWidget(
                path: AppSvg.unlock,
                width: 20.w,
                height: 20.h,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            onSuffixIconTap: () {
              setState(() {
                isConfirmPasswordVisible = !isConfirmPasswordVisible;
              });
            },

            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 3.w, right: 10.w),
              child: AppSvgWidget(
                path:
                    isConfirmPasswordVisible
                        ? AppSvg.eye_show
                        : AppSvg.eye_hide,
                width: 20.w,
                height: 20.h,
              ),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Şifre tekrar alanı zorunludur';
              }
              if (value != widget.passwordController.text) {
                return 'Şifreler eşleşmiyor';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Zaten hesabın var mı?",
          style: AppTextStyle.whiteS12Regular.copyWith(
            color: AppColors.white.withValues(alpha: 0.5),
          ),
        ),
        TextButton(
          onPressed: () {
            context.go(AppRouter.signIn);
          },
          child: Text(
            "Giriş yap",
            style: AppTextStyle.whiteS12Regular.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
