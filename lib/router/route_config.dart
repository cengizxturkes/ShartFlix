import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:my_app/ui/pages/app_start/splash/splash_page.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:my_app/ui/pages/home/home_page.dart';
import 'package:my_app/ui/pages/photo_view/photo_view_page.dart';
import 'package:my_app/ui/pages/profile/profile_page.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
  );

  ///main page
  static const String splash = "/";
  static const String home = "/home";
  static const String signIn = "/sign_in";
  static const String photoView = 'photo_view';
  static const String profile = 'profile';
  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashPage(),
      routes: <RouteBase>[
        //  GoRoute(
        //  name: onBoarding,
        // path: onBoarding,
        // builder: (context, state) => const OnboardingPage(),
        //),
        GoRoute(
          name: photoView,
          path: photoView,
          builder:
              (context, state) => PhotoViewPage(
                arguments: PhotoViewArguments(
                  images: state.extra as List<String>,
                ),
              ),
        ),
        GoRoute(
          name: signIn,
          path: signIn,
          builder: (context, state) => const SignInPage(),
        ),
        GoRoute(
          name: home,
          path: home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: profile,
          path: profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ];
}
