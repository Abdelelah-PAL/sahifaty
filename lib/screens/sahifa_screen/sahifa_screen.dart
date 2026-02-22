import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controllers/evaluations_controller.dart';
import '../../controllers/users_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/evaluations_provider.dart';
import '../../providers/school_provider.dart';
import '../../providers/users_provider.dart';
import '../main_screen/main_screen.dart';
import '../questions_screen/questions_screen.dart';
import '../settings_screen/settings_screen.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/user_profile_badge.dart';
import '../widgets/no_pop_scope.dart';

class SahifaScreen extends StatelessWidget {
  const SahifaScreen({super.key, required this.firstScreen});
  final bool firstScreen;
  
  Widget _buildDrawer(BuildContext context) {
    return SizedBox(
        width: SizeConfig.getProportionalWidth(280), // Increased from 225
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
                     final evaluationsProvider = Get.context!.read<EvaluationsProvider>();
                     final schoolProvider = Get.context!.read<SchoolProvider>();
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
                    final usersProvider =
                        Provider.of<UsersProvider>(context, listen: false);
                    UsersController().logout(usersProvider);
                    // No need to pop as logout usually navigates to login
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

  @override
  Widget build(BuildContext context) {
    if (firstScreen) {
      SizeConfig().init(context);
    }
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    EvaluationsProvider evaluationsProvider =
        Provider.of<EvaluationsProvider>(context);

    final uncategorized =
        EvaluationsController().getEvaluationById(0, evaluationsProvider);
    final evaluatedPercentage =
        (100 - (uncategorized?.percentage ?? 0)).toStringAsFixed(2);
    return NoPopScope(
      child: Scaffold(
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
            automaticallyImplyLeading: usersProvider.isFirstLogin,
            leadingWidth: usersProvider.isFirstLogin ? 56 : 140,
            // adjust
            leading: usersProvider.isFirstLogin
                ? const CustomBackButton()
                : const Padding(
                    padding: EdgeInsetsDirectional.only(start: 12),
                    child: UserProfileBadge(),
                  ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                     if ((Get.locale?.languageCode ?? 'ar') == 'ar') {
                        Scaffold.of(context).openDrawer();
                     } else {
                        Scaffold.of(context).openEndDrawer();
                     }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: (Get.locale?.languageCode ?? 'ar') == 'ar' ? null : _buildDrawer(context),
      drawer: (Get.locale?.languageCode ?? 'ar') == 'ar' ? _buildDrawer(context) : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.getProportionalWidth(75),
              right: SizeConfig.getProportionalWidth(50),
              top: SizeConfig.getProportionalHeight(50),
              bottom: SizeConfig.getProportionalHeight(55)),
          child: Column(
            children: [
              CustomText(
                text: '${"well_done".tr} ${usersProvider.selectedUser?.fullName ?? ''}',
                structHeight: 3,
                textAlign: TextAlign.center,
                fontSize: 24,
                withBackground: false,
              ),
              BarChartWidget(
                evaluationsProvider: evaluationsProvider,
              ),
              SizedBox(
                height: SizeConfig.getProportionalHeight(50),
              ),
              Text(
                "categorized_verses_msg".trParams({'percentage': evaluatedPercentage}),
                textAlign: TextAlign.center,
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                  height: 1.35,
                  leading: 0.0,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.35,
                ),
              ),
              SizedBox(
                height: SizeConfig.getProportionalHeight(50),
              ),
              CustomButton(
                  onPressed: () => {Get.to(const MainScreen())},
                  text: "browse_verses".tr,
                  width: 120,
                  height: 35),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
