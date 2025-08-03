import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/utils/quick_actions_service.dart';

import 'splash_navigator.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final AuthRepository authRepo;

  SplashCubit({required this.navigator, required this.authRepo})
    : super(const SplashState());

  Future<void> fetchInitialData() async {
    if (isClosed) return;
    final isLoggedIn = await _isLoggedIn();
    if (isClosed) return;

    if (isLoggedIn) {
      // Handle user logged in
    }
  }

  Future<void> checkLogin() async {
    if (isClosed) return;

    // Check if quick action was triggered
    final wasQuickAction = await QuickActionsService.wasQuickActionTriggered();
    if (wasQuickAction) {
      // Clear the flag
      await QuickActionsService.clearQuickActionFlag();
      // Navigate directly to discover page
      await navigator.openDiscoverPage();
      return;
    }

    final isLoggedIn = await _isLoggedIn();
    if (isClosed) return;

    if (isLoggedIn) {
      await navigator.openHomePage();
    } else {
      await navigator.openSignIn();
    }
  }

  Future<bool> _isLoggedIn() async {
    final token = await authRepo.getToken();
    final isLoggedIn = token != null;
    return isLoggedIn;
  }
}
