import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_navbar/app_navigation_bar.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/profile/profile_cubit.dart';
import 'package:my_app/ui/pages/profile/profile_navigator.dart';
import 'package:my_app/ui/pages/profile/profile_state.dart';
import 'package:my_app/ui/pages/profile/widget/profile_widgets.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/widgets.dart';

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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state.currentNavigationIndex,
            onTap: (int value) => _cubit.onNavigationChanged(value),
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
                    title: 'Kişisel bilgiler',
                    children: [
                      ProfileMenuItemWidget(
                        icon: Icons.person_outline,
                        title: 'Profil',
                        onTap: () {
                          // TODO: Navigate to profile edit
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.favorite_border,
                        title: 'Favori filmler',
                        onTap: () {
                          // TODO: Navigate to favorite movies
                        },
                      ),
                    ],
                  ),

                  // General Section
                  ProfileSectionWidget(
                    title: 'Genel',
                    children: [
                      ProfileMenuItemWidget(
                        icon: Icons.language,
                        title: 'Dil',
                        onTap: () {
                          // TODO: Navigate to language settings
                        },
                      ),
                    ],
                  ),
                  // About Section
                  ProfileSectionWidget(
                    title: 'Hakkında',
                    children: [
                      ProfileMenuItemWidget(
                        icon: Icons.shield_outlined,
                        title: 'Yasal ve Politikalar',
                        onTap: () {
                          // TODO: Navigate to legal and policies
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.help_outline,
                        title: 'Yardım ve Destek',
                        onTap: () {
                          // TODO: Navigate to help and support
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.dark_mode_outlined,
                        title: 'Koyu Mod',
                        showArrow: false,
                        trailing: AppSwitchWidget(
                          value: state.isDarkMode,
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
                      title: 'Çıkış Yap',
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
  }
}
