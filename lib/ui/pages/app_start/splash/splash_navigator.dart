import 'package:my_app/common/app_navigator/app_navigator.dart';
import 'package:my_app/router/route_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  Future<void> openOnboardingPage() {
    return pushReplacementNamed(AppRouter.onBoarding);
  }

  Future<void> openDiscoverPage() {
    return pushReplacementNamed(AppRouter.discover);
  }
}
