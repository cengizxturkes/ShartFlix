import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/widgets/app_obscure_text_controller/app_obscure_text_controller.dart';
import 'package:my_app/widgets/app_text_field/app_text_field.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';

import 'sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final userCubit = RepositoryProvider.of<UserCubit>(context);
        return SignInCubit(
          navigator: SignInNavigator(context: context),
          authRepo: authRepo,
          userRepo: userRepo,
          userCubit: userCubit,
        );
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({super.key});

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  late ObscureTextController obscurePasswordController;
  final _formKey = GlobalKey<FormState>();

  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    obscurePasswordController = ObscureTextController(obscureText: true);
    _cubit = BlocProvider.of<SignInCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.loginPagePadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.appStartText,
                  style: AppTextStyle.whiteS18SemiBold,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Tempus varius a vitae interdum id tortor elementum tristique eleifend at.",
                  style: AppTextStyle.whiteS12.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                AppTextField(
                  onChanged: (value) {
                    _cubit.changeEmail(email: value);
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
                  controller: emailTextController,
                  hintText: AppLocalizations.of(context)!.emailLabel,
                  prefixIcon: Icon(Icons.email, color: AppColors.textWhite),
                ),
                SizedBox(height: 8.h),
                AppTextField(
                  prefixIcon: Icon(Icons.lock_open, color: AppColors.textWhite),
                  onChanged: (value) {
                    _cubit.changePassword(password: value);
                  },
                  suffixIcon: Icon(
                    obscurePasswordController.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.textWhite,
                  ),
                  controller: passwordTextController,
                  hintText: AppLocalizations.of(context)!.passwordLabel,
                ),
                SizedBox(height: 29.h),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.forgotPassword,
                        style: AppTextStyle.whiteS12Regular.copyWith(
                          decoration:
                              TextDecoration.underline, // işte burası alt çizgi
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    return AppButton(
                      isLoading: state.signInStatus == LoadStatus.loading,
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        context.read<SignInCubit>().signIn();
                      },
                      title: AppLocalizations.of(context)!.signInButton,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
