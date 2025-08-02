import 'package:my_app/common/app_navigator/app_navigator.dart';
import 'package:my_app/router/route_config.dart';

class ProfileNavigator extends AppNavigator {
  ProfileNavigator({required super.context});

  void openSignUpPage() {
    // pushNamed(AppRouter.signUp);
  }

  void navigateToLogin() {
    openSignIn();
  }

  void navigateToProfileDetail() {
    pushNamed(AppRouter.profileDetail);
  }

  void onNavigationChanged(int index) {
    switch (index) {
      case 0:
        pushReplacementNamed(AppRouter.home);
        break;
      case 1:
        // Already on profile page, do nothing
        break;
      default:
        break;
    }
  }
}
