import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/auth/auth_screen.dart';
import 'package:plusclouds/src/home/home_screen.dart';
import 'package:plusclouds/src/provider/app_provider.dart';
import 'package:provider/provider.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AppProvider())],
      child: Consumer<AppProvider>(builder: (context, appProvider, _) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          initialRoute: appProvider.initialRoute,
          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData.light(useMaterial3: true).copyWith(
            primaryColor: appPrimaryColor,
            scaffoldBackgroundColor: appSecondaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: appPrimaryColor,
              foregroundColor: appSecondaryColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: appPrimaryColor, foregroundColor: appSecondaryColor, minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 60)),
            ),
          ),
          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return PageRouteBuilder<void>(
              settings: routeSettings,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                switch (routeSettings.name) {
                  case HomeScreen.routeName:
                    return FadeTransition(opacity: animation, child: const HomeScreen());
                  case AuthScreen.routeName:
                    return FadeTransition(opacity: animation, child: const AuthScreen());
                  default:
                    return const AuthScreen();
                }
              },
            );
          },
        );
      }),
    );
  }
}
