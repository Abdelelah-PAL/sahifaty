import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/users_provider.dart';
import '../widgets/custom_text.dart';
import 'login_screen.dart';
import 'widgets/custom_auth_btn.dart';
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
    _authController.confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _authController = UsersController();
  }

  @override
  Widget build(BuildContext context) {
    UsersProvider authenticationProvider =
        Provider.of<UsersProvider>(context);

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
                    // SizeConfig.customSizedBox(
                    //     179, 179, Image.asset(Assets.pureLogo)),
                    Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.getProportionalHeight(10),
                            bottom: SizeConfig.getProportionalHeight(13)),
                        child: const CustomText(
                          text: "create_an_account",
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
                    CustomAuthenticationTextField(
                      hintText:'أدخل كلمة المرور',
                      obscureText: true,
                      textEditingController:
                          _authController.signUpPasswordController,
                      borderColor:
                          _authController.signUpPasswordTextFieldBorderColor,
                    ),
                    CustomAuthenticationTextField(
                      hintText:'تأكيد كلمة المرور',
                      obscureText: true,
                      textEditingController:
                          _authController.confirmedPasswordController,
                      borderColor:
                          _authController.confirmPasswordTextFieldBorderColor,
                    ),
                    SizeConfig.customSizedBox(null, 50, null),
                    CustomAuthBtn(
                      text: 'التسجيل',
                      onTap: () async {
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
                          var user = await UsersProvider()
                              .signUpWithEmailAndPassword(
                                  _authController.signUpEmailController.text
                                      .trim(),
                                  _authController.signUpPasswordController.text,
                                  authenticationProvider);
                          // UserDetails userDetails = UserDetails(
                          //   userId: user!.uid,
                          //   userTypeId: null,
                          //   email: user.email!,
                          //   username: null,
                          //   subscriber: false,
                          // );
                          // UsersProvider().addUserDetails(userDetails);
                          setState(() {
                            _authController.changeTextFieldsColors(false);
                          });
                          Get.to(() => const LoginScreen(
                                firstScreen: false,
                              ));
                        }
                        UsersProvider().resetLoading();
                        setState(() {
                          UsersController().clearTextFields();
                        });
                      },
                    ),
                    SizeConfig.customSizedBox(null, 50, null),
                    CustomAuthFooter(
                      headingText: "have_account",
                      tailText: "login",
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
                  child:  Center(
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
