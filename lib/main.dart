import 'package:flutter/material.dart';
import 'package:plusclouds/src/utils/preferences/app_storage.dart';

import 'src/app.dart';

void main() async {
  // Need to call this method if you need the binding to be initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage().init();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const MyApp());
}
