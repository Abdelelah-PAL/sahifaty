import 'package:flutter/cupertino.dart';
import '../controllers/users_controller.dart';
import '../core/constants/colors.dart';
import '../models/user.dart';
import '../services/users_services.dart';

class UsersProvider with ChangeNotifier {
  static final UsersProvider _instance = UsersProvider._internal();

  factory UsersProvider() => _instance;

  UsersProvider._internal();

  final UsersServices _usersService = UsersServices();
  bool isLoading = false;
  final String errorMessage = "";

  Future<User> register(String username, String email, String password) async {
    setLoading();
    try {
      final result = await _usersService.register(
        username: username,
        email: email,
        password: password,
      );

      // result can be User or String error
      if (result is User) {
        return result;
      } else {
        // throw error to be caught in UI
        throw Exception(result.toString());
      }
    } finally {
      resetLoading();
    }
  }

  Future<User> login(String email, String password) async {
    setLoading();
    try {
      final result = await _usersService.login(
        email: email,
        password: password,
      );

      // result can be User or String error
      if (result is User) {
        return result;
      } else {
        // throw error to be caught in UI
        throw Exception(result.toString());
      }
    } finally {
      resetLoading();
    }
  }

  Future<void> logout() async {
    await _usersService.logout();
  }

  Future<void> sendPasswordResetEmail(email) async {
    await _usersService.sendPasswordResetEmail(email);
  }

  Future<void> resetSignUpErrorText() async {
    UsersController().signUpErrorText = "";
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
    UsersController().loginErrorText = "";
    notifyListeners();
  }

  void setSignUpErrorText(String key) {
    UsersController().signUpErrorText = key;
    notifyListeners();
  }

  void setLoginErrorText(String key) {
    UsersController().loginErrorText = key;
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
}
