import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/core/constants/assets.dart';
import 'package:sahifaty/models/user.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../models/auth_data.dart';
import '../../providers/users_provider.dart';
import '../sahifa_screen/sahifa_screen.dart';
import '../welcome_screen/welcome_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/no_pop_scope.dart';
import 'forget_password_screen.dart';
import 'sign_up_screen.dart';
import 'widgets/custom_auth_footer.dart';
import 'widgets/custom_auth_textfield.dart';
import 'widgets/custom_auth_textfield_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.firstScreen});

  final bool firstScreen;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UsersController _userController;

  @override
  void initState() {
    super.initState();
    _userController = UsersController();
    _userController.getLoginInfo();
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
    EvaluationsProvider evaluationsProvider =
        Provider.of<EvaluationsProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return NoPopScope(
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
                child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Stack(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.getProportionalWidth(25),
                                  vertical:
                                      SizeConfig.getProportionalWidth(45)),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  SizeConfig.customSizedBox(
                                      1.5,
                                      3.5,
                                      Image.asset(
                                        Assets.logo,
                                        width: 100,
                                        height: 100,
                                      )),
                                  SizeConfig.customSizedBox(null, 15, null),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.getProportionalHeight(
                                              10),
                                          bottom:
                                              SizeConfig.getProportionalHeight(
                                                  13)),
                                      child: CustomText(
                                        text: "welcome_back".tr,
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.blackFontColor,
                                        withBackground: false,
                                      )),
                                  CustomAuthTextFieldHeader(
                                    text: 'email_label'.tr,
                                  ),
                                  CustomAuthenticationTextField(
                                      hintText: 'email_hint'.tr,
                                      obscureText: false,
                                      textEditingController:
                                          _userController.loginEmailController,
                                      borderColor: _userController
                                          .loginPasswordTextFieldBorderColor),
                                  CustomAuthTextFieldHeader(
                                    text: 'password_label'.tr,
                                  ),
                                  CustomAuthenticationTextField(
                                    hintText: 'password_hint'.tr,
                                    obscureText: true,
                                    textEditingController:
                                        _userController.loginPasswordController,
                                    borderColor: _userController
                                        .loginPasswordTextFieldBorderColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: AppColors
                                                      .textFieldBorderColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              width: SizeConfig
                                                  .getProportionalWidth(20),
                                              height: SizeConfig
                                                  .getProportionalHeight(20),
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  checkboxTheme:
                                                      const CheckboxThemeData(), // reset it
                                                ),
                                                child: Checkbox(
                                                  value: _userController
                                                      .rememberMe,
                                                  activeColor: Colors.grey,
                                                  checkColor:
                                                      AppColors.backgroundColor,
                                                  onChanged: (v) => setState(
                                                      () => _userController
                                                          .toggleRememberMe()),
                                                  side: const BorderSide(
                                                      color: AppColors
                                                          .textFieldBorderColor,
                                                      width: 2),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: SizeConfig
                                                    .getProportionalWidth(10)),
                                            child: Text(
                                              "remember_me".tr,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFont,
                                                fontSize: 15,
                                                color: AppColors.blackFontColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () => {
                                          Get.to(() =>
                                              const ForgotPasswordScreen())
                                        },
                                        child: Text(
                                          "forgot_password".tr,
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
                                    text: 'login'.tr,
                                    width: SizeConfig.getProportionalWidth(150),
                                    height:
                                        SizeConfig.getProportionalHeight(50),
                                    onPressed: () async {
                                      try {
                                        // ✅ Check empty fields
                                        _userController.checkEmptyFields(true);
                                        if (!_userController.noneIsEmpty) {
                                          setState(() {
                                            _userController
                                                .changeTextFieldsColors(true);
                                          });
                                          throw Exception(
                                              "all_fields_required".tr);
                                        }

                                        // ✅ Validate email format
                                        if (!_userController.isEmailValid(
                                          _userController
                                              .loginEmailController.text
                                              .trim(),
                                        )) {
                                          setState(() {
                                            _userController
                                                    .loginEmailTextFieldBorderColor =
                                                AppColors.errorColor;
                                          });
                                          throw Exception("invalid_email".tr);
                                        }

                                        // ✅ Indicate loading
                                        setState(() {
                                          _userController
                                              .changeTextFieldsColors(true);
                                          usersProvider.setLoading();
                                        });

                                        // ✅ Try to log in
                                        AuthData authData =
                                            await usersProvider.login(
                                          _userController
                                              .loginEmailController.text
                                              .trim(),
                                          _userController
                                              .loginPasswordController.text,
                                        );

                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setString('accessToken',
                                            authData.accessToken!);

                                        User user = User(
                                            id: authData.user!.id,
                                            fullName: authData.user!.fullName,
                                            email: authData.user!.email);

                                        usersProvider.setSelectedUser(user);
                                        await usersProvider.checkFirstLogin();

                                        // Always save session on successful login, or based on "Remember Me" if that's the requirement
                                        // The user request "keep the user logged in after killing the app" implies we should probably auto-save it.
                                        // However, the original code had "Remember Me".
                                        // If I follow "keep logged in", it usually means persistent session.
                                        // I will save it if rememberMe is true, or maybe always if that's modern standard.
                                        // But let's stick to the existing "Remember Me" checkbox logic if we want to respect that UI choice,
                                        // OR enforce it. The user said "keep the user logged in", so usually that implies default behavior or checking "Remember Me".
                                        // I'll put it inside the existing rememberMe block but also make sure it saves the FULL session not just email/pass for autofill.

                                        if (_userController.rememberMe) {
                                          _userController.saveLoginInfo(
                                            _userController
                                                .loginEmailController.text
                                                .trim(),
                                            _userController
                                                .loginPasswordController.text,
                                          );
                                          // NEW: Save full session for auto-login
                                          await usersProvider.saveUserSession(
                                              user, authData.accessToken!);
                                        }

                                        if (!usersProvider.isFirstLogin) {
                                          await evaluationsProvider
                                              .getQuranChartData(usersProvider
                                                  .selectedUser!.id);
                                          Get.to(() => const SahifaScreen(
                                                firstScreen: false,
                                              ));
                                        } else {
                                          Get.to(() => const WelcomeScreen());
                                        }
                                      } catch (e) {
                                        String message;
                                        if (e
                                            .toString()
                                            .contains("invalid credentials")) {
                                          message = "invalid_credentials".tr;
                                        } else {
                                          message = e
                                              .toString()
                                              .replaceFirst('Exception: ', '');
                                        }

                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              message,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                        );
                                      } finally {
                                        setState(() {
                                          usersProvider.resetLoading();
                                        });
                                      }
                                    },
                                  ),
                                  SizeConfig.customSizedBox(null, 30, null),
                                  CustomAuthFooter(
                                    headingText: "dont_have_account".tr,
                                    tailText: "create_account_action".tr,
                                    onTap: () => {
                                      UsersProvider().resetSignUpErrorText(),
                                      Get.to(() => const SignUpScreen())
                                    },
                                  ),
                                  SizeConfig.customSizedBox(null, 50, null),
                                  SizedBox(
                                    height: 40,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Left logo
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Image.asset(
                                            Assets.organization1STDLogo,
                                            height: 50,
                                          ),
                                        ),

                                        // Center text (true center of screen)
                                        const CustomText(
                                          text: 'Beta 0.0.3',
                                          withBackground: false,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              )),
                        ),
                        if (usersProvider.isLoading)
                          const Center(child: CircularProgressIndicator()),
                      ],
                    )))));
  }
}
