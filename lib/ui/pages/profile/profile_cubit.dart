import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_navigator.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_state.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';

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
    if (isClosed) return;
    emit(state.copyWith(currentNavigationIndex: index));
    navigator.onNavigationChanged(index);
  }

  void toggleDarkMode() {
    if (isClosed) return;
    // AppSettingCubit'i kullanarak tema değişikliğini yap
    final appSettingCubit = navigator.context.read<AppSettingCubit>();
    appSettingCubit.toggleDarkMode();

    // Local state'i güncelle
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void getUser() async {
    final value = await authRepo.getUser();
    if (isClosed) return;

    if (value?.response.code == 200) {
      final newState = state.copyWith(profileResponse: value);
      emit(newState);
    } else {}
  }

  void logout() {
    if (isClosed) return;

    SecureStorageHelper.instance.removeToken();

    navigator.navigateToLogin();
  }
}
