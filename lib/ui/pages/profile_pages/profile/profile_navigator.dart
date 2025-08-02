import 'package:my_app/common/app_navigator/app_navigator.dart';
import 'package:my_app/router/route_config.dart';

class ProfileNavigator extends AppNavigator {
  ProfileNavigator({required super.context});
  void navigateToLogin() {
    openSignIn();
  }

  Future<void> navigateToProfileDetail() async {
    await pushNamed(AppRouter.profileDetail);
  }

  Future<void> navigateToLegalAndPolicies() async {
    await pushNamed(AppRouter.legalAndPolicies);
  }

  Future<void> navigateToHelpAndSupport() async {
    await pushNamed(AppRouter.helpAndSupport);
  }
}
