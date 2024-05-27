import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plusclouds/src/utils/preferences/app_storage.dart';

import 'src/app.dart';

void main() async {
  // Need to call this method if you need the binding to be initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage().init();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  Animate.restartOnHotReload = true;
  runApp(const MyApp());
}
