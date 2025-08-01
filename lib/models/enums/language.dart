import 'package:flutter/material.dart';

enum Language { english, turkish }

extension LanguageExt on Language {
  Locale get locale {
    switch (this) {
      case Language.english:
        return const Locale('en', 'US');
      case Language.turkish:
        return const Locale('tr', 'TR');
    }
  }

  String get code {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.turkish:
        return 'tr';
    }
  }

  static Language? languageFromCode(String code) {
    if (code == Language.english.code) {
      return Language.english;
    } else if (code == Language.turkish.code) {
      return Language.turkish;
    } else {
      return null;
    }
  }
}
