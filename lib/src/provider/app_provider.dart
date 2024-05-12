//app provider
import 'package:flutter/material.dart';

//create a default provider class which holds functions and variables that can be accessed by other classes
class AppProvider with ChangeNotifier {
  //create a variable to hold the current theme
  ThemeMode themeMode = ThemeMode.system;

  //function to change the theme
  void changeTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
