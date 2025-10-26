import 'package:flutter/cupertino.dart';
import '../controllers/users_controller.dart';
import '../core/constants/colors.dart';
import '../models/user.dart';
import '../services/users_services.dart';

class UsersProvider with ChangeNotifier {
  static final UsersProvider _instance = UsersProvider._internal();

  factory UsersProvider() => _instance;

  UsersProvider._internal();

  final UsersServices _authService = UsersServices();
  bool isLoading = false;
  final String errorMessage = "";

  Future<User> signUpWithEmailAndPassword(String email, String password,
      UsersProvider usersProvider) async {
    setLoading();
   User user = await _authService.signUpWithEmailAndPassword(
        email, password, usersProvider);
    return user;
  }

  Future<User> login(String email, String password) async {
    setLoading();
  return User(userId: 'userId', email: 'email', subscriber: false);
  }

  Future<void> logout() async {
    User user = User(userId: "1", email: "email", subscriber: false);
    await _authService.logout();
  }

  Future<void> sendPasswordResetEmail(email) async {
    await _authService.sendPasswordResetEmail(email);
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
