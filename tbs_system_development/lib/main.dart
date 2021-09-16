import 'package:flutter/material.dart';

import 'app/app.dart';
import 'config/app_config.dart';
import 'locator.dart';

void main() {
  setUpLocator();
  var configuredApp = new AppConfig(
      appName: 'TBS Mining',
      flavorName: 'production',
      apiBaseUrl: '',
      child: new App());
  runApp(configuredApp);
}