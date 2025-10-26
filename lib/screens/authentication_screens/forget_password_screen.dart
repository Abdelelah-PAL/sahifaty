import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/users_provider.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_text.dart';
import 'widgets/custom_auth_btn.dart';
import 'widgets/custom_auth_textfield.dart';
import 'widgets/custom_auth_textfield_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text("Forgot Password")),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: _emailController,
    //           decoration: const InputDecoration(labelText: "Email"),
    //           keyboardType: TextInputType.emailAddress,
    //         ),
    //         const SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: _sendPasswordResetEmail,
    //           child: const Text("Send Reset Link"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    var authenticationProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(SizeConfig.getProperVerticalSpace(10)),
            child:  Padding(
              padding: EdgeInsets.only(top: SizeConfig.getProperVerticalSpace(20)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   CustomBackButton(),
                ],
              ),
            )),
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionalWidth(10),
                  vertical: SizeConfig.getProportionalWidth(45)),
              child: Column(children: [

                Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.getProportionalHeight(10),
                        bottom: SizeConfig.getProportionalHeight(13)),
                    child: const CustomText(
                      text: "reset_password",
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackFontColor,
                      withBackground: false,
                    )),
                SizeConfig.customSizedBox(null, 70, null),
                const CustomAuthTextFieldHeader(  text: 'البريد الالكتروني'),
                CustomAuthenticationTextField(
                  hintText: 'example@example.com',
                  obscureText: false,
                  textEditingController:
                      UsersController().forgotPasswordEmailController,
                  borderColor: AppColors.textFieldBorderColor,
                ),
                SizeConfig.customSizedBox(
                  null,
                  15,
                  null,
                ),
                SizeConfig.customSizedBox(null, 15, null),
                CustomAuthBtn(
                    text: "إرسال",
                    onTap: () async {
                      if (UsersController()
                          .forgotPasswordEmailController
                          .text
                          .isEmpty) {
                        Fluttertoast.showToast(
                            msg: "أدخل البريد الإلكتروني");
                        return;
                      }
                      await authenticationProvider.sendPasswordResetEmail(
                          UsersController().forgotPasswordEmailController.text.trim());
                      Fluttertoast.showToast(msg: "لقد تم إرسال رمز تحقق إلى بريدك الإلكتروني");
                    }),
              ])),
        ));
  }
}
