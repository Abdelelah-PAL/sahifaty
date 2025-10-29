import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/models/auth_data.dart';
import 'package:sahifaty/screens/welcome_screen/welcome_screen.dart';
import 'package:sahifaty/screens/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../models/user.dart';
import '../../providers/users_provider.dart';
import '../widgets/custom_text.dart';
import 'login_screen.dart';
import 'widgets/custom_auth_footer.dart';
import 'widgets/custom_auth_textfield.dart';
import 'widgets/custom_error_txt.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late UsersController _authController;

  @override
  void dispose() {
    _authController.signUpConfirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _authController = UsersController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    UsersProvider authenticationProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionalWidth(10),
            vertical: SizeConfig.getProportionalWidth(45)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  children: [
                    SizeConfig.customSizedBox(
                        1.5, 3, Image.asset(Assets.quran)),
                    Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.getProportionalHeight(10),
                            bottom: SizeConfig.getProportionalHeight(13)),
                        child: const CustomText(
                          text: "إنشاء حساب",
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: AppColors.blackFontColor,
                          withBackground: false,
                        )),
                    CustomErrorTxt(
                      text: _authController.signUpErrorText,
                    ),
                    CustomAuthenticationTextField(
                      hintText: 'أدخل البريد الإلكتروني',
                      obscureText: false,
                      textEditingController:
                          _authController.signUpEmailController,
                      borderColor:
                          _authController.signUpEmailTextFieldBorderColor,
                    ),
                    SizeConfig.customSizedBox(null, 50, null),
                    CustomAuthenticationTextField(
                      hintText: 'اسم المستخدم',
                      obscureText: false,
                      textEditingController:
                          _authController.signUpUsernameController,
                      borderColor:
                          _authController.signUpEmailTextFieldBorderColor,
                    ),
                    SizeConfig.customSizedBox(null, 50, null),
                    CustomAuthenticationTextField(
                      hintText: 'أدخل كلمة المرور',
                      obscureText: true,
                      textEditingController:
                          _authController.signUpPasswordController,
                      borderColor:
                          _authController.signUpPasswordTextFieldBorderColor,
                    ),
                    SizeConfig.customSizedBox(null, 50, null),
                    CustomAuthenticationTextField(
                      hintText: 'تأكيد كلمة المرور',
                      obscureText: true,
                      textEditingController:
                          _authController.signUpConfirmedPasswordController,
                      borderColor:
                          _authController.confirmPasswordTextFieldBorderColor,
                    ),
                    SizeConfig.customSizedBox(null, 20, null),
                    CustomButton(
                      onPressed: () async {
                        _authController.checkEmptyFields(false);
                        if (!_authController.noneIsEmpty) {
                          setState(() {
                            _authController.changeTextFieldsColors(false);
                          });
                          return;
                        }

                        _authController.checkMatchedPassword();
                        if (!_authController.isMatched) {
                          setState(() {
                            _authController.changeTextFieldsColors(false);
                          });
                          return;
                        }

                        _authController.checkValidPassword();
                        if (!_authController.passwordIsValid) {
                          setState(() {
                            _authController.changeTextFieldsColors(false);
                          });
                          return;
                        }

                        if (_authController.isMatched &&
                            _authController.passwordIsValid) {
                          try {
                            AuthData authData = await UsersProvider().register(
                              _authController.signUpUsernameController.text
                                  .trim(),
                              _authController.signUpEmailController.text.trim(),
                              _authController.signUpPasswordController.text,
                            );

                            setState(() {
                              _authController.changeTextFieldsColors(false);
                            });
                            UsersController().clearTextFields();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('token', authData.accessToken!);
                            prefs.setString(
                                'refresh_token', authData.refreshToken!);
                            Get.to(() => const WelcomeScreen());
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      },
                      width: SizeConfig.getProportionalWidth(150),
                      height: SizeConfig.getProportionalHeight(50),
                      text: "إنشاء حساب",
                    ),
                    SizeConfig.customSizedBox(null, 20, null),
                    CustomAuthFooter(
                      headingText: "هل تملك حساب؟",
                      tailText: "تسجيل الدخول",
                      onTap: () {
                        UsersProvider().resetSignUpErrorText();
                        Get.to(() => const LoginScreen(
                              firstScreen: false,
                            ));
                      },
                    )
                  ],
                ),
              ),
              if (authenticationProvider.isLoading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
