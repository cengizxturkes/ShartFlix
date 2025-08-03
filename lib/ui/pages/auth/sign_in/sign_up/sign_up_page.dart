// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
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
    return WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.loginPagePadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  _buildSignUpButton(),
                  SizedBox(height: 24.h),
                  const SocialLoginButtons(),
                  SizedBox(height: 32.h),

                  const SignUpFooter(),
                ],
              ),
            ),
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
          title: "Kayıt Ol",
        );
      },
    );
  }
}
