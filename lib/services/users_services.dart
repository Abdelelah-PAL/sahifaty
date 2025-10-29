import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sahifaty/models/auth_data.dart';
import '../models/user.dart';

class UsersServices with ChangeNotifier {
  final String _baseURL = 'https://api.sahifati.org';
  final Duration _timeout = const Duration(seconds: 30);
  final Map<String, String> _authHeaders = {
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  Future<dynamic> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseURL/auth/register'),
            headers: _authHeaders,
            body: json.encode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(_timeout);

      final responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        return AuthData.fromJson(responseData);
      } else {
        return responseData['message'] ?? 'Unknown error';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http
          .post(
            Uri.parse('$_baseURL/auth/login'),
            headers: headers,
            body: json.encode({'email': email, 'password': password}),
          )
          .timeout(_timeout);
      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        return User.fromJson(responseData);
      } else {
        return responseData['message'] ?? 'Unknown error';
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> logout() async {}

  Future<void> sendPasswordResetEmail(email) async {
    try {} catch (e) {
      rethrow;
    }
  }
}
