import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../providers/users_provider.dart';

class UsersServices with ChangeNotifier {
  Future<User> signUpWithEmailAndPassword(
      String email, String password, UsersProvider usersProvider) async {
    try {
      return User(userId: "1", email: "email", subscriber: false);
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected error: $e");
      }
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
