// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_theme/app_themes.dart';
import 'package:my_app/configs/app_configs.dart';

import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/network/api_util/api_util.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/auth/auth_repository_impl.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/repositories/movie/movie_repository_impl.dart';
import 'package:my_app/repositories/user/user_repositoru_impl.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/widgets/loading/app_loading_indicator.dart';
import 'package:my_app/models/enums/language.dart';

import 'router/route_config.dart';

class Shartflix extends StatefulWidget {
  const Shartflix({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShartflixState();
  }
}

class _ShartflixState extends State<Shartflix> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<MovieRepository>(
          create: (context) {
            return MovieRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<UserRepository>(
          create: (context) {
            return UserRepositoryImpl(apiClient: _apiClient);
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) {
              final authRepo = RepositoryProvider.of<AuthRepository>(context);
              return AuthCubit(authRepo: authRepo);
            },
          ),
          BlocProvider<UserCubit>(
            create: (context) {
              final userRepository = RepositoryProvider.of<UserRepository>(
                context,
              );
              return UserCubit(userRepository: userRepository);
            },
          ),
          BlocProvider<AppSettingCubit>(
            create: (_) {
              final deviceLocale = ui.PlatformDispatcher.instance.locale;
              final cubit = AppSettingCubit(initialLocale: deviceLocale);
              // Tema ayarlarını başlangıçta yükle
              cubit.getInitialSetting();
              return cubit;
            },
          ),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (prev, current) {
            return prev.language != current.language ||
                prev.isDarkMode != current.isDarkMode;
          },
          builder: (context, state) {
            // AppColors'ı tema değişikliğinde güncelle
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await AppColors.initialize();
            });

            return GestureDetector(
              onTap: () => _hideKeyboard(context),
              child: GlobalLoaderOverlay(
                useDefaultLoading: false,
                overlayWidgetBuilder:
                    (_) => const Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: AppCircularProgressIndicator(),
                      ),
                    ),
                child: _buildMaterialApp(
                  locale: state.language.locale,
                  isDarkMode: state.isDarkMode,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMaterialApp({required Locale locale, required bool isDarkMode}) {
    return ScreenUtilInit(
      designSize: const Size(402, 844),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConfigs.appName,
          theme: AppThemes(isDarkMode: false).theme, // light
          darkTheme: AppThemes(isDarkMode: true).theme, // dark
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routerConfig: AppRouter.router,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            EasyLocalization.of(context)!.delegate,
          ],

          locale: locale,
          supportedLocales: [Locale('en'), Locale('tr')],
        );
      },
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
