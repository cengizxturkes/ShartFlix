import 'package:flutter/material.dart';
import 'package:my_app/widgets/switch/app_switch_widget.dart';

class ProfileMenuData {
  final String translationKey;
  final IconData icon;
  final VoidCallback? onTap;
  final bool showArrow;
  final Widget? trailing;

  const ProfileMenuData({
    required this.translationKey,
    required this.icon,
    this.onTap,
    this.showArrow = true,
    this.trailing,
  });
}

class ProfileMenuSection {
  final String title;
  final List<ProfileMenuData> items;
  final String? translationKey;

  const ProfileMenuSection({
    required this.title,
    required this.items,
    this.translationKey,
  });
}

class ProfileMenuHelper {
  static const List<ProfileMenuSection> _menuSections = [
    ProfileMenuSection(
      title: 'personalInformation',
      translationKey: 'personalInformation',
      items: [
        ProfileMenuData(translationKey: 'profile', icon: Icons.person_outline),
        ProfileMenuData(
          translationKey: 'favoriteMovies',
          icon: Icons.favorite_border,
        ),
      ],
    ),
    ProfileMenuSection(
      title: 'general',
      translationKey: 'general',
      items: [
        ProfileMenuData(translationKey: 'language', icon: Icons.language),
      ],
    ),
    ProfileMenuSection(
      title: 'about',
      translationKey: 'about',
      items: [
        ProfileMenuData(
          translationKey: 'legalAndPolicies',
          icon: Icons.shield_outlined,
        ),
        ProfileMenuData(
          translationKey: 'helpAndSupport',
          icon: Icons.help_outline,
        ),
        // ProfileMenuData(
        //   translationKey: 'darkMode',
        //   icon: Icons.dark_mode_outlined,
        //   showArrow: false,
        // ),
      ],
    ),
  ];

  static List<ProfileMenuSection> getMenuSections({
    required VoidCallback onProfileTap,
    required VoidCallback onFavoriteMoviesTap,
    required VoidCallback onLanguageTap,
    required VoidCallback onLegalAndPoliciesTap,
    required VoidCallback onHelpAndSupportTap,
    required VoidCallback onDarkModeToggle,
    required bool isDarkMode,
  }) {
    return _menuSections.map((section) {
      return ProfileMenuSection(
        title: section.title,
        translationKey: section.translationKey,
        items:
            section.items.map((item) {
              VoidCallback? onTap;
              Widget? trailing = item.trailing;
              switch (item.translationKey) {
                case 'profile':
                  onTap = onProfileTap;
                  break;
                case 'favoriteMovies':
                  onTap = onFavoriteMoviesTap;
                  break;
                case 'language':
                  onTap = onLanguageTap;
                  break;
                case 'legalAndPolicies':
                  onTap = onLegalAndPoliciesTap;
                  break;
                case 'helpAndSupport':
                  onTap = onHelpAndSupportTap;
                  break;
                case 'darkMode':
                  onTap = onDarkModeToggle;
                  trailing = AppSwitchWidget(
                    value: isDarkMode,
                    onChanged: (_) => onDarkModeToggle(),
                  );
                  break;
              }

              return ProfileMenuData(
                translationKey: item.translationKey,
                icon: item.icon,
                onTap: onTap,
                showArrow: item.showArrow,
                trailing: trailing,
              );
            }).toList(),
      );
    }).toList();
  }
}
