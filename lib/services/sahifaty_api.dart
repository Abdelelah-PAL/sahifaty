import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'app_exception.dart';

class SahifatyApi {
  final String _baseURL = 'https://api.sahifati.org/';
  final Duration _timeout = const Duration(seconds: 30);

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      String refreshToken = prefs.getString('refresh_token')!;

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'X-Refresh-Token': refreshToken,
        'Content-Type': 'application/json',
      };

      var response = await http
          .get(Uri.parse(_baseURL + url), headers: headers)
          .timeout(_timeout);

      responseJson = processedResponse(response);

      if (response.statusCode == 200) {
        return responseJson;
      } else {
        return null;
      }
    }
    on SocketException {
      throw FetchDataException('No Internet connection');
    }
    catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> fetch(Uri uri) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.get(uri, headers: headers).timeout(_timeout);
      responseJson = processedResponse(response);
      if (response.statusCode == 200) {
        return responseJson;
      } else {
        return null;
      }
    }
    on SocketException {
      throw FetchDataException('No Internet connection');
    }
    catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> post({required String url, required dynamic body}) async {
    dynamic responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    String refreshToken = prefs.getString('refresh_token')!;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'X-Refresh-Token': refreshToken,
      'Content-Type': 'application/json',
    };
    try {
      var response = await http
          .post(
        Uri.parse(_baseURL + url),
        body: json.encode(body),
        headers: headers,
      )
          .timeout(_timeout);
      responseJson = processedResponse(response);

    }
    on SocketException {
      throw FetchDataException('No Internet connection');
    }
    catch (ex) {
      rethrow;
    }
    return responseJson;
  }



  Future<dynamic> put({required String url, required dynamic body}) async {
    dynamic responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    String refreshToken = prefs.getString('refresh_token')!;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'X-Refresh-Token': refreshToken,
      'Content-Type': 'application/json',
    };
    try {
      var response = await http
          .put(
        Uri.parse(_baseURL + url),
        body: json.encode(body),
        headers: headers,
      )
          .timeout(_timeout);
      responseJson = processedResponse(response);

    }
    on SocketException {
      throw FetchDataException('No Internet connection');
    }
    catch (ex) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    dynamic responseJson;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      String refreshToken = prefs.getString('refresh_token')!;

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'X-Refresh-Token': refreshToken,
        'Content-Type': 'application/json',
      };
      var response = await http
          .delete(Uri.parse(_baseURL + url), headers: headers)
          .timeout(_timeout);
      responseJson = processedResponse(response);
      if (response.statusCode == 200) {
        return responseJson;
      } else {
        return null;
      }
    }
    on SocketException {
      throw FetchDataException('No Internet connection');
    }
    catch (ex) {
      rethrow;
    }
  }

  dynamic processedResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var jsonBody = json.decode(response.body);
        return jsonBody;
      case 400:
        throw Exception('Bad Request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: Please login again');
      case 403:
        throw Exception('Forbidden: Access denied');
      case 404:
        throw Exception('Not Found: ${response.body}');
      case 422:
        throw Exception('Validation Error: ${response.body}');
      case 500:
        throw Exception('Server Error: Something went wrong');
      case 503:
        throw Exception('Service Unavailable: Please try again later');
      default:
        throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
