import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/colors.dart';
import '../providers/users_provider.dart';
import '../screens/authentication_screens/login_screen.dart';

class UsersController {
  static final UsersController _instance = UsersController._internal();

  factory UsersController() => _instance;

  UsersController._internal();

  TextEditingController usernameController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpUsernameController = TextEditingController();
  TextEditingController signUpConfirmedPasswordController =
      TextEditingController();
  TextEditingController forgotPasswordEmailController = TextEditingController();
  Color signUpEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
  Color signUpPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
  Color signUpUsernameTextFieldBorderColor = AppColors.textFieldBorderColor;
  Color loginEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
  Color loginPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
  Color confirmPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
  bool noneIsEmpty = true;
  bool isMatched = true;
  bool passwordIsValid = true;
  bool rememberMe = true;
  String signUpErrorText = "";
  String loginErrorText = "";

  bool checkEmptyFields(bool login) {
    if (login == false) {
      noneIsEmpty = signUpEmailController.text.isNotEmpty &&
          signUpUsernameController.text.isNotEmpty &&
          signUpPasswordController.text.isNotEmpty &&
          signUpConfirmedPasswordController.text.isNotEmpty;
      signUpErrorText = noneIsEmpty ? "" : "جميع الحقول مطلوبة";
    } else {
      noneIsEmpty = loginEmailController.text.isNotEmpty &&
          loginPasswordController.text.isNotEmpty;
      loginErrorText = noneIsEmpty ? "" : "جميع الحقول مطلوبة";
    }

    return noneIsEmpty;
  }

  void checkMatchedPassword() {
    isMatched = signUpPasswordController.text.trim() ==
        signUpConfirmedPasswordController.text.trim();
    signUpErrorText = !isMatched ? "كلمة المرور غير متطابقة" : "";
  }

  void checkValidPassword() {
    String password = signUpPasswordController.text.trim();
    if (password.length < 6) {
      signUpErrorText = 'يجب أن تحتوي كلمة المرور على ستة حروف على الأقل';
      passwordIsValid = false;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      signUpErrorText = 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';
      passwordIsValid = false;
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      signUpErrorText = 'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';
      passwordIsValid = false;
    } else if (!RegExp(r'\d').hasMatch(password)) {
      signUpErrorText = 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
      passwordIsValid = false;
      passwordIsValid = false;
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      signUpErrorText = 'يجب أن تحتوي كلمة المرور على حرف رمز واحد على الأقل';
      passwordIsValid = false;
      passwordIsValid = false;
    } else {
      signUpErrorText = "";
      passwordIsValid = true;
    }
  }

  void changeTextFieldsColors(bool login) {
    if (!noneIsEmpty) {
      if (login == false) {
        if (signUpEmailController.text.isEmpty) {
          signUpEmailTextFieldBorderColor = AppColors.errorColor;
        } else {
          signUpEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
        }
        if (signUpUsernameController.text.isEmpty) {
          signUpUsernameTextFieldBorderColor = AppColors.errorColor;
        } else {
          signUpUsernameTextFieldBorderColor = AppColors.textFieldBorderColor;
        }
        if (signUpPasswordController.text.isEmpty) {
          signUpPasswordTextFieldBorderColor = AppColors.errorColor;
        } else {
          signUpPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
        }
      } else {
        if (loginEmailController.text.isEmpty) {
          loginEmailTextFieldBorderColor = AppColors.errorColor;
        } else {
          loginEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
        }
        if (loginPasswordController.text.isEmpty) {
          loginPasswordTextFieldBorderColor = AppColors.errorColor;
        } else {
          loginPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
        }
      }

      if (signUpConfirmedPasswordController.text.isEmpty) {
        confirmPasswordTextFieldBorderColor = AppColors.errorColor;
      } else {
        confirmPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
      }
    } else {
      if (login == false) {
        if (!isMatched || !passwordIsValid) {
          signUpEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
          signUpUsernameTextFieldBorderColor = AppColors.textFieldBorderColor;
          signUpPasswordTextFieldBorderColor = AppColors.errorColor;
          confirmPasswordTextFieldBorderColor = AppColors.errorColor;
        } else {
          signUpErrorText = "";
          signUpEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
          signUpPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
          signUpUsernameTextFieldBorderColor = AppColors.textFieldBorderColor;
          confirmPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
        }
      } else {
        loginPasswordTextFieldBorderColor = AppColors.textFieldBorderColor;
        loginEmailTextFieldBorderColor = AppColors.textFieldBorderColor;
      }
      return;
    }
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
  }

  Future<void> saveLoginInfo(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('saved for $email', true);
  }

  Future<Map<String, String>> getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';
    loginEmailController.text = email;
    loginPasswordController.text = password;
    return {'email': email, 'password': password};
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
  }

  void logout(UsersProvider usersProvider) {
    usersProvider.logout();

    Get.to(const LoginScreen(firstScreen: false));
  }

  void clearTextFields() {
    signUpEmailController.clear();
    signUpUsernameController.clear();
    signUpPasswordController.clear();
    signUpConfirmedPasswordController.clear();
  }
}
