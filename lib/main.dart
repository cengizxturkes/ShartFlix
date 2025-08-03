import 'dart:io';

import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:my_app/ShartFlix.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  final config = ClarityConfig(
    projectId: "sorjsvxn1f",
    logLevel:
        LogLevel
            .None, // Note: Use "LogLevel.Verbose" value while testing to debug initialization issues.
  );
  runApp(
    ClarityWidget(
      clarityConfig: config,
      app: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('tr')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr'),
        child: const Shartflix(),
      ),
    ),
  );
}
