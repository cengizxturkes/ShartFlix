import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_shadow/app_shadows.dart';
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
    emailTextController = TextEditingController(text: 'mobile@newwave.com');
    passwordTextController = TextEditingController(text: "Aa@12345");
    obscurePasswordController = ObscureTextController(obscureText: true);
    _cubit = BlocProvider.of<SignInCubit>(context);
    _cubit.changeEmail(email: emailTextController.text);
    _cubit.changePassword(password: passwordTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("Sign In")]));
  }
}
