import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sahifaty/services/sahifaty_api.dart';
import '../models/user.dart';
import '../providers/users_provider.dart';
import 'app_exception.dart';

class UsersServices with ChangeNotifier {
  final String _baseURL = 'https://api.sahifati.org/';
  final Duration _timeout = const Duration(seconds: 30);
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> register({
    required String username,
    required String login,
    required String email,
    required String password,
  }) async {
    try {
      var response = await http
          .post(
            Uri.parse('$_baseURL/url'),
            headers: headers,
            body: json.encode({
              'username': username,
              'login': login,
              'email': email,
              'password': password,
            }),
          )
          .timeout(_timeout);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return User.fromJson(responseData);
      } else {
        throw FetchDataException(responseData['message']);
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      return User(userId: "1", email: "email", subscriber: false);
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
