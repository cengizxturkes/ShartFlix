import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configs/app_configs.dart';
import 'package:my_app/database/share_preferences_helper.dart';
import 'package:my_app/models/enums/language.dart';

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
    emit(state.copyWith(language: currentLanguage, isDarkMode: currentTheme));
  }

  void changeLanguage({required Language language}) async {
    await SharedPreferencesHelper.setCurrentLanguage(language);
    emit(state.copyWith(language: language));
  }

  void updateTheme(bool isDarkMode) {
    SharedPreferencesHelper.setThemePreference(isDarkMode);
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
}
