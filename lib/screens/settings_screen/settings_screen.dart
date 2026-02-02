import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/colors.dart';
import '../../services/localization_service.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../providers/general_provider.dart';
import '../../providers/users_provider.dart';
import '../../controllers/users_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
             backgroundColor: AppColors.backgroundColor,
             elevation: 0,
             leading: const CustomBackButton(),
             title: Text("settings".tr, style: TextStyle(color: AppColors.blackFontColor),),
             centerTitle: true,
          ),
        ),
      ),
      body: Directionality(
        textDirection: Get.locale?.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              children: [
                ListTile(
                  title: Text(
                    "language".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: DropdownButton<String>(
                    value: Locale(Get.locale?.languageCode ?? 'ar', 'AE')
                                .languageCode ==
                            'ar'
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
                    onChanged: (String? val) {
                      if (val != null) {
                        LocalizationService().changeLocale(val);
                        setState(() {});
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
              ],
          ),
        ),
      ),
    );
  }
}
