import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_cubit.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_navigator.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_state.dart';
import 'package:my_app/ui/pages/profile_pages/profile/widget/profile_widgets.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileChildPage();
  }
}

class ProfileChildPage extends StatefulWidget {
  const ProfileChildPage({super.key});

  @override
  State<ProfileChildPage> createState() => _ProfileChildPageState();
}

class _ProfileChildPageState extends State<ProfileChildPage> {
  late ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      builder: (context, appSettingState) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.fetchUserStatus == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Profil', style: AppTextStyle.whiteS15Regular),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: SafeArea(
                child: ProfileContent(
                  onProfileTap: _handleProfileTap,
                  onFavoriteMoviesTap: _handleFavoriteMoviesTap,
                  onLanguageTap: _handleLanguageTap,
                  onLegalAndPoliciesTap: _handleLegalAndPoliciesTap,
                  onHelpAndSupportTap: _handleHelpAndSupportTap,
                  onDarkModeToggle: _handleDarkModeToggle,
                  onLogout: _handleLogout,
                  isDarkMode: appSettingState.isDarkMode,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleProfileTap() async {
    await _cubit.navigator.navigateToProfileDetail().then((value) {
      _cubit.getUser();
    });
  }

  Future<void> _handleFavoriteMoviesTap() async {
    await _cubit.navigator.navigateToProfileDetail().then((value) {
      _cubit.getUser();
    });
  }

  void _handleLanguageTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LanguageSelectionModal(),
    );
  }

  void _handleLegalAndPoliciesTap() {
    _cubit.navigator.navigateToLegalAndPolicies();
  }

  void _handleHelpAndSupportTap() {
    _cubit.navigator.navigateToHelpAndSupport();
  }

  void _handleDarkModeToggle() {
    _cubit.toggleDarkMode();
  }

  void _handleLogout() {
    _cubit.logout();
  }
}
