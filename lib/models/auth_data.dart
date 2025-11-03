import 'package:sahifaty/models/user.dart';

class AuthData {
  String? statusCode;
  String? message;
  String? accessToken;
  String? refreshToken;
  User? user;

  AuthData({
    this.statusCode,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      User userData = User.fromJson(json['user']);
      return AuthData(
          statusCode: json['status'],
          message: json['message'],
          accessToken: json['accessToken'],
          refreshToken: json['refreshToken'],
          user: userData);
    } else {
      return AuthData(
        statusCode: json['status'],
        message: json['message'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
    }
  }

  @override
  String toString() {
    return 'AuthData(statusCode: $statusCode, message: $message, accessToken: $accessToken, refreshToken: $refreshToken )';
  }
}
