import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_app/common/app_theme/app_themes.dart';
import 'package:my_app/configs/app_configs.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/network/api_util/api_util.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/auth/auth_repository_impl.dart';
import 'package:my_app/repositories/user/user_repositoru_impl.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/widgets/loading/app_loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            create: (context) {
              return AppSettingCubit();
            },
          ),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (prev, current) {
            return prev.language != prev.language;
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: GlobalLoaderOverlay(
                useDefaultLoading: false,
                overlayWidgetBuilder: (_) {
                  return Center(
                    child: Container(
                      color: Colors.grey,
                      width: 40,
                      height: 40,
                      child: const Center(
                        child: AppCircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                child: _buildMaterialApp(locale: state.language.locale),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMaterialApp({required Locale locale}) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConfigs.appName,
      theme: AppThemes().theme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
