import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controllers/users_controller.dart';
import '../../core/utils/size_config.dart';
import '../../providers/evaluations_provider.dart';
import '../../providers/school_provider.dart';
import '../../providers/users_provider.dart';
import '../questions_screen/questions_screen.dart';
import '../settings_screen/settings_screen.dart';
import 'custom_text.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.getProportionalWidth(280),
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.getProportionalHeight(100),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                onTap: () {
                  Get.to(() => const SettingsScreen());
                },
                title: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    SizedBox(
                      width: SizeConfig.getProportionalWidth(10),
                    ),
                    CustomText(
                      text: "settings".tr,
                      withBackground: false,
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  final evaluationsProvider = context.read<EvaluationsProvider>();
                  final schoolProvider = context.read<SchoolProvider>();
                  await schoolProvider.getQuickQuestionsSchool();
                  await evaluationsProvider.getAllEvaluations();
                  Get.to(const QuestionsScreen());
                },
                title: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Icon(
                      Icons.question_answer_sharp,
                      size: 30,
                    ),
                    SizedBox(
                      width: SizeConfig.getProportionalWidth(10),
                    ),
                    CustomText(
                      text: "quick_questions".tr,
                      withBackground: false,
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  final usersProvider = context.read<UsersProvider>();
                  UsersController().logout(usersProvider);
                },
                title: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(
                      width: SizeConfig.getProportionalWidth(10),
                    ),
                    Text(
                      'logout'.tr,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
