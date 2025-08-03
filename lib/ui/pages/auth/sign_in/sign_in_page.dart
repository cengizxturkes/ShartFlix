// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/ui/pages/auth/sign_in/widget/auth_widgets.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SignInCubit>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            child: Stack(
              children: [
                /// Scroll içeriği
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 80.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 250.h), // üst boşluk
                      const SignInHeader(),
                      SignInForm(
                        cubit: _cubit,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        formKey: _formKey,
                      ),
                      SizedBox(height: 24.h),
                      _buildSignInButton(),
                      SizedBox(height: 36.h),
                      const SocialLoginButtons(),
                    ],
                  ),
                ),

                /// Sabit footer
                Align(
                  alignment: Alignment.bottomCenter,
                  child: const SignInFooter(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return AppButton(
          isLoading: state.signInStatus == LoadStatus.loading,
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            context.read<SignInCubit>().signIn();
          },
          title: "Giriş Yap",
        );
      },
    );
  }
}
