import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:my_app/ui/pages/app_start/splash/splash_page.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:my_app/ui/pages/home/home_page.dart';
import 'package:my_app/ui/pages/discover/discover_page.dart';

import 'package:my_app/ui/pages/profile_pages/add_photo/add_photo_page.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_page.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/profile_detail_page.dart';
import 'package:my_app/ui/pages/html_viewer/html_viewer_alternative_page.dart';

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
  static const String photoView = '/photo_view';
  static const String profile = '/profile';
  static const String profileDetail = '/profile_detail';
  static const String addPhoto = '/add_photo';
  static const String discover = '/discover';
  static const String legalAndPolicies = '/legal_and_policies';
  static const String helpAndSupport = '/help_and_support';

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      name: splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: signIn,
      name: signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: home,
      name: home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: discover,
      name: discover,
      builder: (context, state) => const DiscoverPage(),
    ),

    GoRoute(
      name: profile,
      path: profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      name: profileDetail,
      path: profileDetail,
      builder: (context, state) => const ProfileDetailPage(),
    ),
    GoRoute(
      name: addPhoto,
      path: addPhoto,
      builder: (context, state) => const AddPhotoPage(),
    ),
    GoRoute(
      name: legalAndPolicies,
      path: legalAndPolicies,
      builder:
          (context, state) => const HtmlViewerAlternativePage(
            title: 'Yasal ve Gizlilik Politikası',
            htmlAssetPath: 'assets/html/legal.html',
          ),
    ),
    GoRoute(
      name: helpAndSupport,
      path: helpAndSupport,
      builder:
          (context, state) => const HtmlViewerAlternativePage(
            title: 'Yardım ve Destek',
            htmlAssetPath: 'assets/html/help.html',
          ),
    ),
  ];
}
