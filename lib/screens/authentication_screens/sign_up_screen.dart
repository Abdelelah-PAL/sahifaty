import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/screens/widgets/custom_button.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/assets.dart';
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
                          _authController.confirmedPasswordController,
                      borderColor:
                          _authController.confirmPasswordTextFieldBorderColor,
                    ),
                    SizeConfig.customSizedBox(null, 20, null),
                    CustomButton(
                        onPressed: () {},
                        width: 150,
                        height: 50,
                        text: "إنشاء حساب"),
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
