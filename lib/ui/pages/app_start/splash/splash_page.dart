import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_images/app_images.dart';
import 'package:my_app/database/share_preferences_helper.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:my_app/ui/pages/app_start/splash/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit(
          navigator: SplashNavigator(context: context),
          authRepo: RepositoryProvider.of<AuthRepository>(context),
        );
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashCubit _cubit;
  late AppSettingCubit _appSettingCubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SplashCubit>();
    _appSettingCubit = context.read<AppSettingCubit>();
    _setup();
  }

  void _setup() async {
    await _appSettingCubit.getInitialSetting();
    await AppColors.initialize();
    await Future.delayed(const Duration(seconds: 1));
    await _runOnboardingIfNeed();
    await _cubit.fetchInitialData();
    await _cubit.checkLogin();
  }

  Future<void> _runOnboardingIfNeed() async {
    final isOnboarded = await SharedPreferencesHelper.isOnboarded();

    if (!isOnboarded) {
      await SharedPreferencesHelper.setOnboarded(isOnboarded: true);
      await _cubit.navigator.openOnboardingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppImages.sinFlixSplash)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
