import 'package:flutter/material.dart';
import 'package:plusclouds/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class representing shared storage used throughout the app.
class AppStorage {
  static late SharedPreferences _sharedPrefs;

  /// Private constructor for singleton pattern.
  static final AppStorage _instance = AppStorage._internal();
  factory AppStorage() => _instance;
  AppStorage._internal();

  /// Initializes the shared preferences instance.
  ///
  /// This method should be called at the beginning of your app's lifecycle
  /// to ensure that shared preferences are properly initialized.
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  /// Retrieves the stored access token.
  ///
  /// Returns the access token if it exists, or an empty string if not found.
  String get accessToken {
    debugPrint("$debugPreferencesRead retriving access_token : ${_sharedPrefs.getString("access_token") ?? ""}");
    return _sharedPrefs.getString("access_token") ?? "";
  }

  /// Stores the provided access token.
  ///
  /// This method sets the "access_token" key with the provided token in
  /// the app's local storage using shared preferences.
  set accessToken(String token) {
    debugPrint("$debugPreferencesWrite Storing access_token : $token");
    _sharedPrefs.setString("access_token", token);
  }

  /// Retrieves the stored account ID.
  ///
  /// Returns the account ID if it exists, or an empty string if not found.
  String get accountId {
    debugPrint("$debugPreferencesRead retriving account_id : ${_sharedPrefs.getString("account_id") ?? ""}");
    return _sharedPrefs.getString("account_id") ?? "";
  }

  /// Stores the provided account ID.
  ///
  /// This method sets the "account_id" key with the provided ID in
  /// the app's local storage using shared preferences.
  set accountId(String accountId) {
    debugPrint("$debugPreferencesWrite Storing account_id : $accountId");
    _sharedPrefs.setString("account_id", accountId);
  }

  /// Retrieves the stored user ID.
  ///
  /// Returns the user ID if it exists, or an empty string if not found.
  String get userId {
    debugPrint("$debugPreferencesRead retriving user_id : ${_sharedPrefs.getString("user_id") ?? ""}");
    return _sharedPrefs.getString("user_id") ?? "";
  }

  /// Stores the provided user ID.
  ///
  /// This method sets the "user_id" key with the provided ID in
  /// the app's local storage using shared preferences.
  set userId(String userId) {
    debugPrint("$debugPreferencesWrite Storing user_id : $userId");
    _sharedPrefs.setString("user_id", userId);
  }
}
