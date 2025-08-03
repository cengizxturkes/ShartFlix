import 'package:my_app/common/app_navigator/app_navigator.dart';
import 'package:my_app/router/route_config.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required super.context});

  void navigateToHome() {
    openHomePage();
  }

  void navigateToSignIn() {
    openSignIn();
  }

  Future<void> navigateToLegalAndPolicies() async {
    await pushNamed(AppRouter.legalAndPolicies);
  }

  void navigateToSignUp() {
    pushNamed(AppRouter.signUp);
  }
}
