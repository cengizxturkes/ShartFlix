import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/database/share_preferences_helper.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/profile/profile_navigator.dart';
import 'package:my_app/ui/pages/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileNavigator navigator;
  final AuthRepository authRepo;
  final MovieRepository movieRepo;

  ProfileCubit({
    required this.navigator,
    required this.authRepo,
    required this.movieRepo,
  }) : super(const ProfileState()) {
    getUser();
  }

  void onNavigationChanged(int index) {
    emit(state.copyWith(currentNavigationIndex: index));
    navigator.onNavigationChanged(index);
  }

  void toggleDarkMode() {
    SharedPreferencesHelper.setThemePreference(!state.isDarkMode);
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void getUser() async {
    final value = await SecureStorageHelper.instance.getUser();
    if (value != null) {
      final newState = state.copyWith(profileResponse: value);
      emit(newState);
    } else {}
  }

  void logout() {
    SecureStorageHelper.instance.removeUser();
    SecureStorageHelper.instance.removeToken();

    navigator.navigateToLogin();
  }
}
