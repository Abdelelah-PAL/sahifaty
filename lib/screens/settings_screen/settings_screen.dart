import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahifaty/core/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/colors.dart';
import '../../services/localization_service.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../providers/general_provider.dart';
import '../../providers/users_provider.dart';
import '../../controllers/users_controller.dart';
import 'privacy_policy_screen.dart';
import '../widgets/no_pop_scope.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TapGestureRecognizer _emailRecognizer;

  @override
  void initState() {
    super.initState();
    _emailRecognizer = TapGestureRecognizer()..onTap = _launchEmail;
  }

  @override
  void dispose() {
    _emailRecognizer.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@sahifati.org',
      query: 'subject=Feedback',
    );
    try {
      if (!await launchUrl(emailLaunchUri)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open email client'.tr),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return NoPopScope(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
             backgroundColor: AppColors.backgroundColor,
             elevation: 0,
             leading: const CustomBackButton(),
             title: Text("settings".tr, style: const TextStyle(color: AppColors.blackFontColor),),
             centerTitle: true,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              children: [
                ListTile(
                  title: Text(
                    "language".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: DropdownButton<String>(
                    value: (Get.locale?.languageCode ?? 'ar') == 'ar'
                        ? 'Arabic'
                        : 'English',
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'Arabic',
                        child: Text("العربية"),
                      ),
                      DropdownMenuItem(
                        value: 'English',
                        child: Text("English"),
                      ),
                    ],
                    onChanged: (String? val) async {
                      if (val != null) {
                        await LocalizationService().changeLocale(val);
                        if (mounted) {
                          setState(() {});
                        }
                        print(val);
                      }
                    },
                  ),
                ),
                const Divider(),
                Consumer<GeneralProvider>(
                  builder: (context, generalProvider, _) {
                    return SwitchListTile(
                      title: Text(
                        'dark_mode'.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: generalProvider.themeMode == ThemeMode.dark,
                      onChanged: (val) {
                        generalProvider.toggleTheme();
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: AppColors.primaryPurple),
                  title: Text(
                    'privacy_policy_title'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Get.to(() => const PrivacyPolicyScreen());
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    'logout'.tr,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    final usersProvider =
                        Provider.of<UsersProvider>(context, listen: false);
                    UsersController().logout(usersProvider);
                    // No need to pop as logout usually navigates to login
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: Text(
                    'delete_account'.tr,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    // Show confirmation dialog
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('delete_account_confirm_title'.tr),
                          content: Text('delete_account_confirm_message'.tr),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('cancel'.tr),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: Text('confirm'.tr),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed == true && context.mounted) {
                      try {
                        final usersProvider =
                            Provider.of<UsersProvider>(context, listen: false);
                        await usersProvider.deleteAccount();
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('delete_account_success'.tr),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('delete_account_error'.tr),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    }
                  },
                ),

                const Divider(),
                SizeConfig.customSizedBox(null, 4, null),

                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.getProportionalHeight(10),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "${'feedback'.tr} ",
                        ),
                        TextSpan(
                          text: "  info@sahifati.org",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: _emailRecognizer,
                        ),
                      ],
                    ),
                  ),
                )
              ],
          ),
        ),
      ),
    );
  }
}
