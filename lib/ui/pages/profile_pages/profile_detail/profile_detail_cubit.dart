import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';

import 'package:my_app/ui/pages/profile_pages/profile_detail/profile_detail_navigator.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/profile_detail_state.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/widget/pro_modal_widget.dart';

class ProfileDetailCubit extends Cubit<ProfileDetailState> {
  final ProfileDetailNavigator navigator;
  final AuthRepository authRepo;
  final MovieRepository movieRepo;

  ProfileDetailCubit({
    required this.navigator,
    required this.authRepo,
    required this.movieRepo,
  }) : super(const ProfileDetailState()) {
    getFavoriteMovies();
  }

  void getUser() async {
    final value = await SecureStorageHelper.instance.getUser();
    if (isClosed) return;

    if (value != null) {
      final newState = state.copyWith(profileResponse: value);
      emit(newState);
    } else {}
  }

  void getFavoriteMovies() async {
    final value = await movieRepo.getFavoriteMovies();
    if (isClosed) return;

    if (value.response.code == 200) {
      final newState = state.copyWith(favoriteMovies: value);
      emit(newState);
    } else {}
  }

  void setCurrentNavigationIndex(int index) {
    final newState = state.copyWith(currentNavigationIndex: index);
    emit(newState);

    // Handle navigation based on index
    switch (index) {
      case 0:
        // Navigate to home page
        navigator.navigateToHome();
        break;
      case 1:
        // Navigate to profile page
        navigator.navigateToProfile();
        break;
      default:
        break;
    }
  }

  void onPressedGetPro() {
    showModalBottomSheet(
      context: navigator.context,

      isScrollControlled: true,

      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ProModalWidget(
              onClose: () => Navigator.of(context).pop(),
              onSeeAllTokens: () => Navigator.of(context).pop(),
            ),
          ),
    );
  }
}
