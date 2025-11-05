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
import '../../providers/users_provider.dart';
import '../widgets/custom_text.dart';
import 'login_screen.dart';
import 'widgets/custom_auth_footer.dart';
import 'widgets/custom_auth_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late UsersController _userController;

  @override
  void dispose() {
    _userController.signUpConfirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _userController = UsersController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    UsersProvider authenticationProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                child: Center(
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
                      CustomAuthenticationTextField(
                        hintText: 'أدخل البريد الإلكتروني',
                        obscureText: false,
                        textEditingController:
                            _userController.signUpEmailController,
                        borderColor:
                            _userController.signUpEmailTextFieldBorderColor,
                      ),
                      SizeConfig.customSizedBox(null, 50, null),
                      CustomAuthenticationTextField(
                        hintText: 'اسم المستخدم',
                        obscureText: false,
                        textEditingController:
                            _userController.signUpUsernameController,
                        borderColor:
                            _userController.signUpEmailTextFieldBorderColor,
                      ),
                      SizeConfig.customSizedBox(null, 50, null),
                      CustomAuthenticationTextField(
                        hintText: 'أدخل كلمة المرور',
                        obscureText: true,
                        textEditingController:
                            _userController.signUpPasswordController,
                        borderColor:
                            _userController.signUpPasswordTextFieldBorderColor,
                      ),
                      SizeConfig.customSizedBox(null, 50, null),
                      CustomAuthenticationTextField(
                        hintText: 'تأكيد كلمة المرور',
                        obscureText: true,
                        textEditingController:
                            _userController.signUpConfirmedPasswordController,
                        borderColor:
                            _userController.confirmPasswordTextFieldBorderColor,
                      ),
                      SizeConfig.customSizedBox(null, 20, null),
                      CustomButton(
                        onPressed: () async {
                          try {
                            _userController.checkEmptyFields(false);
                            // ✅ Check for empty fields
                            if (!_userController.noneIsEmpty) {
                              setState(() {
                                _userController.changeTextFieldsColors(false);
                              });
                              throw Exception("جميع الحقول مطلوبة");
                            }
                            // ✅ Validate email format
                            if (!_userController.isEmailValid(
                              _userController.signUpEmailController.text.trim(),
                            )) {
                              setState(() {
                                _userController.signUpEmailTextFieldBorderColor =
                                    AppColors.errorColor;
                              });
                              throw Exception("أدخل بريدًا إلكترونيًا صحيحًا");
                            }
                            // ✅ Check password validity
                            _userController.checkValidPassword();
                            if (!_userController.passwordIsValid) {
                              setState(() {
                                _userController.changeTextFieldsColors(false);
                              });
                              throw Exception("كلمة المرور غير صالحة");
                            }
                            // ✅ Check password match
                            _userController.checkMatchedPassword();
                            if (!_userController.isMatched) {
                              setState(() {
                                _userController.changeTextFieldsColors(false);
                              });
                              throw Exception("كلمتا المرور غير متطابقتان");
                            }

                            // ✅ If all good → register user
                            AuthData authData = await UsersProvider().register(
                              _userController.signUpUsernameController.text
                                  .trim(),
                              _userController.signUpEmailController.text.trim(),
                              _userController.signUpPasswordController.text,
                            );

                            setState(() {
                              _userController.changeTextFieldsColors(false);
                            });

                            UsersController().clearTextFields();

                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString(
                                'accessToken', authData.accessToken!);
                            // prefs.setString('refresh_token', authData.refreshToken!);

                            Get.to(() => const WelcomeScreen());
                          } catch (e) {
                            // ✅ All validation & register errors handled here
                            String message;

                            if (e.toString().contains("email already in use")) {
                              message = "البريد الإلكتروني مسجّل سابقًا";
                            } else {
                              message =
                                  e.toString().replaceFirst('Exception: ', '');
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  message,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            );
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
