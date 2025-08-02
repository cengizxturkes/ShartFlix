part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final Language language;
  final bool isDarkMode;

  const AppSettingState({
    this.language = AppConfigs.defaultLanguage,
    this.isDarkMode = true, // Varsayılan olarak dark mode
  });

  @override
  List<Object?> get props => [language, isDarkMode];

  AppSettingState copyWith({Language? language, bool? isDarkMode}) {
    return AppSettingState(
      language: language ?? this.language,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
