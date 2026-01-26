import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:sahifaty/providers/users_provider.dart';
import 'package:sahifaty/screens/main_screen/main_screen.dart';
import '../../controllers/evaluations_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/school_provider.dart';
import '../questions_screen/questions_screen.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/user_profile_badge.dart';

class SahifaScreen extends StatelessWidget {
  const SahifaScreen({super.key});


  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    EvaluationsProvider evaluationsProvider =
        Provider.of<EvaluationsProvider>(context);
    final schoolProvider = context.read<SchoolProvider>();

    final uncategorized =
        EvaluationsController().getEvaluationById(0, evaluationsProvider);
    final evaluatedPercentage =
        (100 - (uncategorized?.percentage ?? 0)).toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: usersProvider.isFirstLogin,
        leadingWidth: usersProvider.isFirstLogin ? 56 : 140, // adjust
        leading: usersProvider.isFirstLogin
            ? const CustomBackButton()
            : const Padding(
          padding: EdgeInsetsDirectional.only(start: 12),
          child: UserProfileBadge(),
        ),        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: SizedBox(
        width: SizeConfig.getProportionalWidth(225),
        child: Drawer(
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.getProportionalHeight(100),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () {},
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
                      const CustomText(
                        text: "إعدادات",
                        withBackground: false,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () async {
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
                      const CustomText(
                        text: "الأسئلة السريعة",
                        withBackground: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.getProportionalWidth(75),
              right: SizeConfig.getProportionalWidth(75),
              top: SizeConfig.getProportionalHeight(50),
              bottom: SizeConfig.getProportionalHeight(55)),
          child: Column(
            children: [
              CustomText(
                text:
                    'مرحبًا ${usersProvider.selectedUser!.fullName} \n هذه هي صحيفتك',
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
                '$evaluatedPercentage% من آيات القرآن أصبحت مصنّفة في صحيفتك',
                textAlign: TextAlign.center,
                locale: const Locale('ar'),
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
                height: SizeConfig.getProportionalHeight(100),
              ),
              CustomButton(
                  onPressed: () => {Get.to(const MainScreen())},
                  text: "تصفّح الآيات",
                  width: 120,
                  height: 35),
              // SizedBox(
              //   height: SizeConfig.getProportionalHeight(10),
              // ),
              // SizedBox(
              //   width: SizeConfig.getProportionalWidth(170),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         mainAxisSize: MainAxisSize.min,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           CustomButton(
              //               onPressed: () => {},
              //               icon: Icons.notes_outlined,
              //               width: 40,
              //               height: 35),
              //           const CustomText(
              //               text: "النصائح", withBackground: false, fontSize: 14)
              //         ],
              //       ),
              //       Column(
              //         mainAxisSize: MainAxisSize.min,
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           CustomButton(
              //               onPressed: () => {},
              //               icon: Icons.check_circle_outline_outlined,
              //               width: 40,
              //               height: 35),
              //           const CustomText(
              //               text: "صفحة الآيات",
              //               withBackground: false,
              //               fontSize: 14)
              //         ],
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
