import 'package:my_app/common/app_navigator/app_navigator.dart';
import 'package:my_app/router/route_config.dart';

class ProfileDetailNavigator extends AppNavigator {
  ProfileDetailNavigator({required super.context});

  void navigateToHome() {
    pushReplacementNamed(AppRouter.home);
  }

  Future<void> navigateToAddPhoto() async {
    await pushNamed(AppRouter.addPhoto);
  }
}
