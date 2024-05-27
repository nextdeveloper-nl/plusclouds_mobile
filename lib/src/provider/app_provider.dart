//app provider
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plusclouds/api.dart';
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/auth/auth_screen.dart';
import 'package:plusclouds/src/home/home_screen.dart';
import 'package:plusclouds/src/home/plusclouds_web.dart';
import 'package:plusclouds/src/utils/preferences/app_storage.dart';

//create a default provider class which holds functions and variables that can be accessed by other classes
class AppProvider with ChangeNotifier {
  //create a variable to hold the current theme
  ThemeMode themeMode = ThemeMode.system;
  String initialRoute = AppStorage().accessToken == "" ? AuthScreen.routeName : HomeScreen.routeName;
  Widget homeBody = const PluscloudsWeb();

  ///function to change the theme
  void changeTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  ///Function to get the accounts from the API and update the homeBody
  void iamAccountsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getAccounts();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  ///Function to get the users from the API and update the homeBody
  void iamUsersHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getUsers();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }

    notifyListeners();
  }

  void crmAccountsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getCRMAccounts();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['iam_account_id']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void crmUserHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getCRMUsers();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['iam_user_id']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void crmAccountsManagersHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getCRMAccountManagers();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void crmOpportunitiesHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getCRMOpportunities();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void crmQuotesHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getCRMQuotes();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void marketplaceDashboardHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getMarketplaceDashboard();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void marketplaceMarketsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getMarketplaceMarkets();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name'] ?? "No Name"),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void marketplaceProductsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getMarketplaceProducts();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void marketplaceProductCatalogsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getMarketplaceProductCatalogs();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void marketplaceSubscriptionsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getMarketplaceSubscriptions();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['name']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void supportTicketsHomeBody(BuildContext context) async {
    Navigator.of(context).pop();
    homeBody = Center(child: loadingAnimation);
    notifyListeners();
    try {
      final response = await API().getSupportTickets();
      homeBody = ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(response[index]['subject']),
            subtitle: Text(response[index]['id']),
          ).animate(delay: Duration(milliseconds: index * 100)).slideX(begin: -1.0, end: 0.0, curve: Curves.easeInOut);
        },
      );
    } catch (error) {
      if (error.runtimeType == DioException) {
        apiFailedAnimationBuilder((error as DioException).response!.statusCode!);
      } else {
        homeBody = Center(child: Text(error.toString()));
      }
    }
    notifyListeners();
  }

  void changeHomeBody(BuildContext context) {
    notifyListeners();
  }

  void logoutUser(BuildContext context) {
    AppStorage().accessToken = "";
    AppStorage().accountId = "";
    initialRoute = AuthScreen.routeName;
    Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
    notifyListeners();
  }

  void apiFailedAnimationBuilder(int statusCode) {
    switch (statusCode) {
      case 404:
        homeBody = const Center(child: Text('404'));
      default:
        homeBody = Center(child: Text(statusCode.toString()));
    }
    notifyListeners();
  }
}
