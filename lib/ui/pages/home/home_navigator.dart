import 'package:my_app/common/app_navigator/app_navigator.dart';
import 'package:my_app/router/route_config.dart';

class HomeNavigator extends AppNavigator {
  HomeNavigator({required super.context});

  void openSignUpPage() {
    // pushNamed(AppRouter.signUp);
  }

  void navigateToProfile() {
    pushReplacementNamed(AppRouter.profile);
  }

  void onNavigationChanged(int index) {
    switch (index) {
      case 0:
        // Already on home page, do nothing or refresh if needed
        break;
      case 1:
        pushReplacementNamed(AppRouter.profile);
        break;
    }
  }
}
