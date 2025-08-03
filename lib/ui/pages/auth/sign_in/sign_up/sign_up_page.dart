// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/sign_up_navigator.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/sign_up_state.dart';
import 'package:my_app/ui/pages/auth/sign_in/widget/social_login_buttons.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/widget/sign_up_widgets.dart';

import 'sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final userCubit = RepositoryProvider.of<UserCubit>(context);
        return SignUpCubit(
          navigator: SignUpNavigator(context: context),
          authRepo: authRepo,
          userRepo: userRepo,
          userCubit: userCubit,
        );
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatefulWidget {
  const SignUpChildPage({super.key});

  @override
  State<SignUpChildPage> createState() => _SignUpChildPageState();
}

class _SignUpChildPageState extends State<SignUpChildPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late SignUpCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SignUpCubit>(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: AppDimens.loginPagePadding,
            right: AppDimens.loginPagePadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SocialLoginButtons(),

              SizedBox(height: 24.h),
              const SignUpFooter(),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.loginPagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignUpHeader(),
              SignUpForm(
                cubit: _cubit,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                formKey: _formKey,
              ),
              SizedBox(height: 24.h),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Kullanıcı sözleşmesini ",
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',

                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    TextSpan(
                      text: "okudum ve kabul ediyorum.",
                      style: TextStyle(
                        fontFamily: 'Euclid Circular A',
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),

                    TextSpan(
                      text: " Bu sözleşmeyi okuyarak devam ediniz lütfen.",
                      style: AppTextStyle.whiteS12Regular.copyWith(
                        color: AppColors.white.withValues(alpha: 0.5),
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // kullanıcı sözleşmesi sayfasına yönlendirme
                            },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 38.h),
              _buildSignUpButton(),

              SizedBox(height: 100.h), // Buton için boşluk
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return AppButton(
          isLoading: state.signUpStatus == LoadStatus.loading,
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            _cubit.signUp(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
            );
          },
          title: "Şimdi Kaydol",
        );
      },
    );
  }
}
