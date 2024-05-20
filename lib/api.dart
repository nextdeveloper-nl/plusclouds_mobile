import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plusclouds/constants.dart';
import 'package:plusclouds/src/utils/preferences/app_storage.dart';

/// An API service for making HTTP requests.
class API {
  static const String apiUrl = "https://apiv4.plusclouds.com";
  static const String authUrl = "https://auth2.plusclouds.com";
  late Dio _dio;
  late String accessToken;
  late Response response;

  API() {
    // CONFIGURE DIO OPTIONS
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: const Duration(milliseconds: 5000), // max wait time of request (type of milliseconds)
      receiveTimeout: const Duration(milliseconds: 5000), // max wait time of response (type of milliseconds)
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AppStorage().accessToken}",
      },
    );

    _dio = Dio(options);
  }

  API.options() {
    // CONFIGURE DIO OPTIONS
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      method: "OPTIONS",
      connectTimeout: const Duration(milliseconds: 5000), // max wait time of request (type of milliseconds)
      receiveTimeout: const Duration(milliseconds: 5000), // max wait time of response (type of milliseconds)
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AppStorage().accessToken}",
      },
    );

    _dio = Dio(options);
  }
  API.auth() {
    // CONFIGURE DIO OPTIONS
    BaseOptions options = BaseOptions(
      baseUrl: authUrl,
      connectTimeout: const Duration(milliseconds: 5000), // max wait time of request (type of milliseconds)
      receiveTimeout: const Duration(milliseconds: 5000), // max wait time of response (type of milliseconds)
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    _dio = Dio(options);
  }

  /// GET request
  Future<dynamic> get(String endpoint) async {
    try {
      debugPrint("$debugRequestSent GET Request Sending ... ${_dio.options.baseUrl}$endpoint");
      response = await _dio.get(endpoint);
      response = await _dio.request(endpoint);
      debugPrint("$debugSuccess GET Request Successfuly sent.");
      return response.data;
    } on DioException catch (error) {
      debugPrint("$debugError Rethrowing Error ... ${error.response}");
      rethrow;
    }
  }

  /// OPTIONS request
  Future<dynamic> options(String endpoint) async {
    try {
      debugPrint("$debugRequestSent OPTION Request Sending ... ${_dio.options.baseUrl}$endpoint");
      response = await _dio.request(endpoint);
      debugPrint("$debugSuccess OPTION Request Successfuly sent.");
      return response.data;
    } catch (error) {
      debugPrint("$debugError Rethrowing Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      debugPrint("$debugRequestSent Post Request Sending ... ${_dio.options.baseUrl}$endpoint");
      debugPrint("$debugRequestSent Post Request Data ... ${data.toString()}");
      response = await _dio.post(endpoint, data: data);
      debugPrint("$debugSuccess POST Request Successfuly sent.");
      return response.data;
    } on DioException catch (error) {
      debugPrint("$debugError Rethrowing Error ... ${error.response}");
      rethrow;
    }
  }

  /// PATCH/UPDATE request
  Future<dynamic> patch(String endpoint, dynamic data) async {
    try {
      debugPrint("$debugRequestSent Patch Request Sending ... ${_dio.options.baseUrl}$endpoint");
      debugPrint("$debugRequestSent Patch Request Data ... ${data.toString()}");
      response = await _dio.patch(endpoint, data: data);
      debugPrint("$debugSuccess Patch Request Successfuly sent.");
      return response.data;
    } catch (error) {
      debugPrint("$debugError Rethrowing Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// UPLOAD any type of file
  Future<String> uploadFile(File file, String endpoint, String parameter) async {
    try {
      debugPrint("$debugRequestSent MultiPart Request Sending ... ${_dio.options.baseUrl}$endpoint");
      var request = http.MultipartRequest("POST", Uri.parse("${_dio.options.baseUrl}$endpoint"));
      var data = await http.MultipartFile.fromPath(parameter, file.path);
      request.files.add(data);
      var response = await request.send();
      debugPrint("$debugSuccess MultiPart Request Successfuly sent.");
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      return responseString;
    } catch (error) {
      debugPrint("$debugError Rethrowing Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// OAuth password token
  Future<dynamic> oAuthPasswordToken(String username, String password, String grantType) async {
    try {
      final response =
          await get("/oauth/password-token?client_id=$clientId&client_secret=$clientSecret&grant_type=$grantType&username=$username&password=$password");
      debugPrint("$debugResponse oAuthPasswordToken() Response:  ${response.toString()}");
      AppStorage().accessToken = response['access_token'];
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing oAuthPasswordToken() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// OAuth CSRF request
  Future<dynamic> oAuthCSRF() async {
    try {
      final response = await get("/security/csrf");
      debugPrint("$debugResponse oAuthCSRF() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing oAuthCSRF() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// OAuth Get-Logins request
  Future<dynamic> oAuthGetLogins(String email) async {
    try {
      final csrf = await oAuthCSRF();
      final response = await get("/get-logins?email=$email&client_id=$clientId&csrf=$csrf");
      debugPrint("$debugResponse oAuthGetLogins Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing oAuthGetLogins Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// OAuth Get-me request
  Future<dynamic> oAuthGetMe() async {
    try {
      final response = await get("/iam/my/contact");
      debugPrint("$debugResponse oAuthGetMe() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing oAuthGetMe() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// OAuth Login request
  Future<dynamic> oAuthLogin(String username, String password) async {
    try {
      final response = await post("/oauth/token", {
        "username": username,
        "password": password,
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": grantType,
      });
      debugPrint("$debugResponse oAuthLogin() Response:  ${response.toString()}");
      AppStorage().accessToken = response['access_token'];
      final getMeResponse = await API().oAuthGetMe();
      AppStorage().accountId = getMeResponse['data']['id'];
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing oAuthLogin() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// OAuth Login request
  Future<dynamic> oAuthLogout() async {
    try {
      AppStorage().accessToken = "";
      AppStorage().accountId = "";
    } catch (error) {
      debugPrint("$debugError Rethrowing oAuthLogout() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get a options
  Future<dynamic> getOptions(String endpoint) async {
    try {
      final response = await options(endpoint);
      debugPrint("$debugResponse getOptions() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getOptions() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get a list of accounts
  Future<dynamic> getAccounts() async {
    try {
      final response = await get("/iam/accounts");
      debugPrint("$debugResponse getAccounts() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getAccounts() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get a list of users
  Future<dynamic> getUsers() async {
    try {
      final response = await get("/iam/users");
      debugPrint("$debugResponse getUsers() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getUsers() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Crm accounts
  Future<dynamic> getCRMAccounts() async {
    try {
      final response = await get("/crm/accounts");
      debugPrint("$debugResponse getCRMAccounts() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getCRMAccounts() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Crm Users
  Future<dynamic> getCRMUsers() async {
    try {
      final response = await get("/crm/users");
      debugPrint("$debugResponse getCRMUsers() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getCRMUsers() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get CRM Account Managers
  Future<dynamic> getCRMAccountManagers() async {
    try {
      final response = await get("/crm/account-managers");
      debugPrint("$debugResponse getCRMAccountManagers() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getCRMAccountManagers() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get CRM Opportunities
  Future<dynamic> getCRMOpportunities() async {
    try {
      final response = await get("/crm/opportunities");
      debugPrint("$debugResponse getCRMOpportunities() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getCRMOpportunities() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get CRM Quotes
  Future<dynamic> getCRMQuotes() async {
    try {
      final response = await get("/crm/quotes");
      debugPrint("$debugResponse getCRMQuotes() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getCRMQuotes() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Marketplace Markets
  Future<dynamic> getMarketplaceMarkets() async {
    try {
      final response = await get("/marketplace/markets");
      debugPrint("$debugResponse getMarketplaceMarkets() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getMarketplaceMarkets() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Marketplace Products
  Future<dynamic> getMarketplaceProducts() async {
    try {
      final response = await get("/marketplace/products");
      debugPrint("$debugResponse getMarketplaceMarkets() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getMarketplaceMarkets() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Marketplace Product Catalogs
  Future<dynamic> getMarketplaceProductCatalogs() async {
    try {
      final response = await get("/marketplace/product-catalogs");
      debugPrint("$debugResponse getMarketplaceProductCatalogs() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getMarketplaceProductCatalogs() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Marketplace Subscriptions
  Future<dynamic> getMarketplaceSubscriptions() async {
    try {
      final response = await get("/marketplace/subscriptions");
      debugPrint("$debugResponse getMarketplaceSubscriptions() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getMarketplaceSubscriptions() Error ... ${error.toString()}");
      rethrow;
    }
  }

  /// Get Support Tickets
  Future<dynamic> getSupportTickets() async {
    try {
      final response = await get("/support/tickets");
      debugPrint("$debugResponse getSupportTickets() Response:  ${response.toString()}");
      return response;
    } catch (error) {
      debugPrint("$debugError Rethrowing getSupportTickets() Error ... ${error.toString()}");
      rethrow;
    }
  }
}
