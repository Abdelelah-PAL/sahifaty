import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sahifaty/models/auth_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart' as google_sign_in;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../controllers/users_controller.dart';
import '../core/constants/colors.dart';
import '../models/user.dart';
import '../services/users_services.dart';


class UsersProvider with ChangeNotifier {
  static final UsersProvider _instance = UsersProvider._internal();

  factory UsersProvider() => _instance;

  UsersProvider._internal();

  User? selectedUser;

  final UsersServices _usersService = UsersServices();
  bool isLoading = false;
  bool isFirstLogin = false;

  Future<AuthData> register(
      String username, String email, String password) async {
    setLoading();
    try {
      final result = await _usersService.register(
        username: username,
        email: email,
        password: password,
      );

      // result can be User or String error
      if (result is AuthData) {
        return result;
      } else {
        // throw error to be caught in UI
        throw result;
      }
    } finally {
      resetLoading();
    }
  }

  Future<AuthData> login(String email, String password) async {
    setLoading();
    try {
      final result = await _usersService.login(
        email: email,
        password: password,
      );
      // result can be User or String error
      if (result is AuthData) {
        return result;
      } else {
        throw result;
      }
    } catch (ex) {
      rethrow;
    } finally {
      resetLoading();
    }
  }


//   Future<AuthData> signInWithGoogle() async {
//     setLoading();
//     try {
//       final google_sign_in.GoogleSignIn googleSignIn =
//       google_sign_in.GoogleSignIn(scopes: ['email']);
//
//       final google_sign_in.GoogleSignInAccount? googleUser =
//       await googleSignIn.signIn();
// `
//       if (googleUser == null) throw 'Google Sign In aborted';
//
//       final google_sign_in.GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       final String? idToken = googleAuth.idToken;
//
//       if (idToken == null) throw 'Could not retrieve ID Token';
//
//       final result = await _usersService.loginWithGoogle(idToken);
//       if (result is AuthData) return result;
//
//       throw result;
//     } finally {
//       resetLoading();
//     }
//   }

  Future<AuthData> signInWithFacebook() async {
    setLoading();
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken? accessToken = loginResult.accessToken;
        if (accessToken == null) {
          throw 'Could not retrieve Access Token';
        }
        final result =
            await _usersService.loginWithFacebook(accessToken.tokenString);
        if (result is AuthData) {
          return result;
        } else {
          throw result;
        }
      } else {
        throw 'Facebook Sign In failed: ${loginResult.message}';
      }
    } catch (ex) {
      rethrow;
    } finally {
      resetLoading();
    }
  }

  Future<void> logout() async {
    await _usersService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    await prefs.remove('accessToken');
    selectedUser = null;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(email) async {
    await _usersService.sendPasswordResetEmail(email);
  }

  Future<void> resetSignUpErrorText() async {
    UsersController().signUpEmailTextFieldBorderColor =
        AppColors.textFieldBorderColor;
    UsersController().signUpPasswordTextFieldBorderColor =
        AppColors.textFieldBorderColor;
    UsersController().confirmPasswordTextFieldBorderColor =
        AppColors.textFieldBorderColor;
    notifyListeners();
  }

  Future<void> resetLoginErrorText() async {
    UsersController().loginEmailTextFieldBorderColor =
        AppColors.textFieldBorderColor;
    UsersController().loginPasswordTextFieldBorderColor =
        AppColors.textFieldBorderColor;
    notifyListeners();
  }

  void setLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setSelectedUser(User user) {
    selectedUser = user;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedUserData =
      json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      
      selectedUser = User.fromJson(extractedUserData);
      notifyListeners();
      return true;
    }

    Future<void> saveUserSession(User user, String accessToken) async {
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(user.toMap());
      await prefs.setString('userData', userData);
      await prefs.setString('accessToken', accessToken);
    } 

  Future<void> checkFirstLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    isFirstLogin = email == '' && password == '';
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    setLoading();
    try {
      final result = await _usersService.deleteAccount(selectedUser!.id);
      if (result == true) {
        // Clear all user data
        await logout();
      } else {
        throw result;
      }
    } catch (ex) {
      rethrow;
    } finally {
      resetLoading();
    }
  }
}
