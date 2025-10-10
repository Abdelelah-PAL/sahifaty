import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class PieChartAssessmentScreen extends StatelessWidget {
  const PieChartAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              const Text(
                textDirection: TextDirection.rtl,
                'تهانينا! \n لقد أتممت التقييم الأولي',
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
                  // fontFamily: 'YourArabicFont',
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                width: 200,
                height: 240,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 0,
                    sections: [
                      PieChartSectionData(
                        color: AppColors.uncategorizedColor,
                        value: 40,
                        radius:150,
                      ),
                      PieChartSectionData(
                        color: AppColors.desireColor,
                        value: 30,
                        radius:150,
                      ),
                      PieChartSectionData(
                        color: AppColors.hardColor,
                        value: 15,
                        radius:150,
                      ),
                      PieChartSectionData(
                        color: AppColors.easyColor,
                        value: 7,
                        radius:150,
                      ),
                      PieChartSectionData(
                        color: AppColors.revisionColor,
                        value: 8,
                        radius:150,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
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
                  // fontFamily: 'YourArabicFont',
                ),
              ),
              const SizedBox(
                height: 60,
              ),
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
                  // fontFamily: 'YourArabicFont',
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                width: 155,
                height: 35,
                child: FloatingActionButton.extended(
                  onPressed: null,
                  backgroundColor: AppColors.buttonColor,
                  label: const Text(
                    'اذهب إلى صحيفتي',
                    style: TextStyle(
                        color: AppColors.backgroundColor, fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
