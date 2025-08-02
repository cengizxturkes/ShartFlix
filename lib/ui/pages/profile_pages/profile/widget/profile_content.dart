import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/ui/pages/profile_pages/profile/widget/profile_widgets.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';

class ProfileContent extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onFavoriteMoviesTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onLegalAndPoliciesTap;
  final VoidCallback onHelpAndSupportTap;
  final VoidCallback onDarkModeToggle;
  final VoidCallback onLogout;
  final bool isDarkMode;

  const ProfileContent({
    super.key,
    required this.onProfileTap,
    required this.onFavoriteMoviesTap,
    required this.onLanguageTap,
    required this.onLegalAndPoliciesTap,
    required this.onHelpAndSupportTap,
    required this.onDarkModeToggle,
    required this.onLogout,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final menuSections = ProfileMenuHelper.getMenuSections(
      onProfileTap: onProfileTap,
      onFavoriteMoviesTap: onFavoriteMoviesTap,
      onLanguageTap: onLanguageTap,
      onLegalAndPoliciesTap: onLegalAndPoliciesTap,
      onHelpAndSupportTap: onHelpAndSupportTap,
      onDarkModeToggle: onDarkModeToggle,
      isDarkMode: isDarkMode,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeaderWidget(),
          SizedBox(height: 24.h),
          ProfileMenuList(sections: menuSections),
          SizedBox(height: 32.h),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AppButton(title: 'logout'.tr(), onPressed: onLogout),
    );
  }
}
