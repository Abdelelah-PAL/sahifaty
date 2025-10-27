import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/screens/welcome_screen/welcome_screen.dart';
import 'package:sahifaty/screens/widgets/custom_button.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../providers/users_provider.dart';
import '../widgets/custom_text.dart';
import 'forget_password_screen.dart';
import 'sign_up_screen.dart';
import 'widgets/custom_auth_btn.dart';
import 'widgets/custom_auth_footer.dart';
import 'widgets/custom_auth_textfield.dart';
import 'widgets/custom_auth_textfield_header.dart';
import 'widgets/custom_error_txt.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.firstScreen});

  final bool firstScreen;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UsersController _authController;

  @override
  void initState() {
    super.initState();
    _authController = UsersController();
    _authController.getLoginInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.firstScreen) {
      SizeConfig().init(context);
    }
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    UsersProvider authenticationProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getProportionalWidth(25),
                      vertical: SizeConfig.getProportionalWidth(45)),
                  child: Column(children: [
                    SizeConfig.customSizedBox(
                        1.5, 3, Image.asset(Assets.quran)),
                    Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.getProportionalHeight(10),
                            bottom: SizeConfig.getProportionalHeight(13)),
                        child: const CustomText(
                          text: "أهلًا بك مجدّدًا",
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: AppColors.blackFontColor,
                          withBackground: false,
                        )),
                    CustomErrorTxt(
                      text: _authController.loginErrorText,
                    ),
                    const CustomAuthTextFieldHeader(
                      text: 'البريد الإلكتروني',
                    ),
                    CustomAuthenticationTextField(
                        hintText: 'example@example.com',
                        obscureText: false,
                        textEditingController:
                            _authController.loginEmailController,
                        borderColor:
                            _authController.loginPasswordTextFieldBorderColor),
                    const CustomAuthTextFieldHeader(
                      text: 'كلمة المرور',
                    ),
                    CustomAuthenticationTextField(
                      hintText: 'أدخل كلمة المرور',
                      obscureText: true,
                      textEditingController:
                          _authController.loginPasswordController,
                      borderColor:
                          _authController.loginPasswordTextFieldBorderColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColors.textFieldBorderColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: SizeConfig.getProportionalWidth(20),
                                height: SizeConfig.getProportionalHeight(20),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    checkboxTheme:
                                        const CheckboxThemeData(), // reset it
                                  ),
                                  child: Checkbox(
                                    value: _authController.rememberMe,
                                    activeColor: Colors.grey,
                                    checkColor: AppColors.backgroundColor,
                                    onChanged: (v) => setState(() =>
                                        _authController.toggleRememberMe()),
                                    side: const BorderSide(
                                        color: AppColors.textFieldBorderColor,
                                        width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.getProportionalWidth(10)),
                              child: Text(
                                "تذكرني",
                                style: TextStyle(
                                  fontFamily: AppFonts.primaryFont,
                                  fontSize: 15,
                                  color: AppColors.blackFontColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () =>
                              {Get.to(() => const ForgotPasswordScreen())},
                          child: Text(
                            "نسيت كلمة المرور",
                            style: TextStyle(
                              fontFamily: AppFonts.primaryFont,
                              fontSize: 16,
                              color: AppColors.errorColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizeConfig.customSizedBox(null, 30, null),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      width: 150,
                      height: 50,
                      onPressed: () async {
                        _authController.checkEmptyFields(true);
                        if (!_authController.noneIsEmpty) {
                          setState(() {
                            _authController.changeTextFieldsColors(true);
                          });
                          return;
                        } else {
                          setState(() {
                            _authController.changeTextFieldsColors(true);
                            authenticationProvider.isLoading = true;
                          });

                          var user = await UsersProvider().login(
                            _authController.loginEmailController.text.trim(),
                            _authController.loginPasswordController.text,
                          );

                          if (user == null) {
                            setState(() {
                              _authController.loginErrorText =
                                  "خطأ في البريد الالكتروني أو كلمة المرور";
                              authenticationProvider.isLoading = false;
                            });
                            return;
                          } else {
                            if (_authController.rememberMe == true) {
                              _authController.saveLoginInfo(
                                user.email,
                                _authController.loginPasswordController.text,
                              );
                            }

                            Get.to(const WelcomeScreen());
                          }
                          UsersProvider().resetLoading();
                        }
                      },
                    ),
                    SizeConfig.customSizedBox(null, 20, null),
                    CustomAuthFooter(
                      headingText: "لا تملك حساب؟",
                      tailText: "قم بإنشاء حساب",
                      onTap: () => {
                        UsersProvider().resetSignUpErrorText(),
                        Get.to(() => const SignUpScreen())
                      },
                    ),
                  ])),
            ),
            if (authenticationProvider.isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ));
  }
}
