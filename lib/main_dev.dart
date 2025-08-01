import 'package:flutter/material.dart';
import 'package:my_app/ShartFlix.dart';

import 'configs/app_configs.dart';
import 'configs/app_env_config.dart';

void main() async {
  AppConfigs.env = Environment.dev;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Shartflix());
}
