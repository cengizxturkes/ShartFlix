import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configs/app_configs.dart';
import 'package:my_app/database/share_preferences_helper.dart';
import 'package:my_app/models/enums/language.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit({required Locale initialLocale})
    : super(
        AppSettingState(
          language:
              initialLocale.languageCode == 'tr'
                  ? Language.turkish
                  : Language.english,
        ),
      );

  Future<void> getInitialSetting() async {
    final currentLanguage = await SharedPreferencesHelper.getCurrentLanguage();
    final currentTheme = await SharedPreferencesHelper.getThemePreference();

    // AppColors'ı güncelle
    AppColors.isDarkMode = currentTheme;

    if (isClosed) return;
    emit(state.copyWith(language: currentLanguage, isDarkMode: currentTheme));
  }

  void changeLanguage({required Language language}) async {
    await SharedPreferencesHelper.setCurrentLanguage(language);
    if (isClosed) return;
    emit(state.copyWith(language: language));
  }

  void updateTheme(bool isDarkMode) async {
    await SharedPreferencesHelper.setThemePreference(isDarkMode);
    await SharedPreferencesHelper.setThemeManually(true);

    // AppColors'ı güncelle
    AppColors.isDarkMode = isDarkMode;

    if (isClosed) return;
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  void toggleDarkMode() {
    updateTheme(!state.isDarkMode);
  }
}
