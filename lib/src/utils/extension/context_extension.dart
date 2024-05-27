import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// An extension on [BuildContext] providing utility properties.
extension ContextExtension on BuildContext {
  /// Gets the height of the screen in logical pixels.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Gets the width of the screen in logical pixels.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Retrieves the [AppLocalizations] instance for internationalization.
  ///
  /// This property allows easy access to localized strings and messages
  /// defined using the Flutter Internationalization (i18n) package.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
