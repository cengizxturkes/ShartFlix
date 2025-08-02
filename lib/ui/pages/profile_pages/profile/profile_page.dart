import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_navbar/app_navigation_bar.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_cubit.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_navigator.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_state.dart';
import 'package:my_app/ui/pages/profile_pages/profile/widget/profile_widgets.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final movieRepo = RepositoryProvider.of<MovieRepository>(context);
        return ProfileCubit(
          navigator: ProfileNavigator(context: context),
          authRepo: authRepo,
          movieRepo: movieRepo,
        );
      },
      child: const ProfileChildPage(),
    );
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
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: state.currentNavigationIndex,
                onTap: (int value) => _cubit.onNavigationChanged(value),
              ),
              appBar: AppBar(
                title: Text('Profil', style: AppTextStyle.whiteS15Regular),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with user info
                      ProfileHeaderWidget(),
                      const SizedBox(height: 24),
                      // Personal Information Section
                      ProfileSectionWidget(
                        title: 'personalInformation'.tr(),
                        children: [
                          ProfileMenuItemWidget(
                            icon: Icons.person_outline,
                            title: 'profile'.tr(),
                            onTap: () async {
                              await _cubit.navigator
                                  .navigateToProfileDetail()
                                  .then((value) {
                                    _cubit.getUser();
                                  });
                            },
                          ),
                          ProfileMenuItemWidget(
                            icon: Icons.favorite_border,
                            title: 'favoriteMovies'.tr(),
                            onTap: () async {
                              await _cubit.navigator
                                  .navigateToProfileDetail()
                                  .then((value) {
                                    _cubit.getUser();
                                  });
                            },
                          ),
                        ],
                      ),

                      // General Section
                      ProfileSectionWidget(
                        title: 'general'.tr(),
                        children: [
                          ProfileMenuItemWidget(
                            icon: Icons.language,
                            title: 'language'.tr(),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder:
                                    (context) => const LanguageSelectionModal(),
                              );
                            },
                          ),
                        ],
                      ),
                      // About Section
                      ProfileSectionWidget(
                        title: 'about'.tr(),
                        children: [
                          ProfileMenuItemWidget(
                            icon: Icons.shield_outlined,
                            title: 'legalAndPolicies'.tr(),
                            onTap: () {
                              // TODO: Navigate to legal and policies
                            },
                          ),
                          ProfileMenuItemWidget(
                            icon: Icons.help_outline,
                            title: 'helpAndSupport'.tr(),
                            onTap: () {
                              // TODO: Navigate to help and support
                            },
                          ),
                          ProfileMenuItemWidget(
                            icon: Icons.dark_mode_outlined,
                            title: 'darkMode'.tr(),
                            showArrow: false,
                            trailing: AppSwitchWidget(
                              value: appSettingState.isDarkMode,
                              onChanged: (value) => _cubit.toggleDarkMode(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Logout Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: AppButton(
                          title: 'logout'.tr(),
                          onPressed: () => _cubit.logout(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
