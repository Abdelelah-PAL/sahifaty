import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../celebration_screen/celebration_screen.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class SahifaScreen extends StatelessWidget {
  const SahifaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: const CustomBackButton(),
          ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.getProportionalHeight(50),
                bottom: SizeConfig.getProportionalHeight(55)),
            child: Column(
              children: [
                const CustomText(
                  text: 'تهانينا! \n لقد أتممت التقييم الأولي',
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  structHeight: 2,
                  withBackground: false,
                ),
                SizeConfig.customSizedBox(null, 10, null),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: [
                        PieChartSectionData(
                          color: AppColors.uncategorizedColor,
                          value: 40,
                          radius: 150,
                        ),
                        PieChartSectionData(
                          color: AppColors.desireColor,
                          value: 30,
                          radius: 150,
                        ),
                        PieChartSectionData(
                          color: AppColors.hardColor,
                          value: 15,
                          radius: 150,
                        ),
                        PieChartSectionData(
                          color: AppColors.easyColor,
                          value: 7,
                          radius: 150,
                        ),
                        PieChartSectionData(
                          color: AppColors.revisionColor,
                          value: 8,
                          radius: 150,
                        ),
                      ],
                    ),
                  ),
                ),
                SizeConfig.customSizedBox(null, 10, null),
                const Text(
                  'لقد تم تصنيف 23% من آيات القرآن في صحيفتك',
                  textAlign: TextAlign.center,
                  locale: Locale('ar'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: true,
                    height: 1.35,
                    leading: 0.0,
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.35,
                  ),
                ),
                SizeConfig.customSizedBox(null, 30, null),
                const Text(
                  'هذه الصحيفة هي نقطة البداية\nالعمل الحقيقي يبدأ الآن',
                  textAlign: TextAlign.center,
                  locale: Locale('ar'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: true,
                    height: 1.35,
                    leading: 0.0,
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionalHeight(70)),
                CustomButton(
                  onPressed: () => {Get.to(const CelebrationScreen())},
                  text: 'اذهب إلى صحيفتي',
                  width: 155,
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
