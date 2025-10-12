import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahifaty/screens/assessment_screen/assessment_screen.dart';
import 'package:sahifaty/screens/widgets/custom_text.dart';
import '../../core/constants/assets.dart';
import '../../core/utils/size_config.dart';
import '../../core/constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.customSizedBox(null, 6, null),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: CustomText(
                text: 'أهلًا بك في صحيفتي!',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
                textAlign: TextAlign.center,
                withBackground: false,
              ),
            ),
            SizeConfig.customSizedBox(null, 20, null),
            const Center(
              child: SizedBox(
                  width: 300,
                  child: CustomText(
                    text:
                        'سنقوم بطرح بعض الأسئلة السريعة\nلتكوين صحيفتك المبدئية.\nستبنى هذه الصحيفة على مدى إلمامك بالقرآن الكريم',
                    fontSize: 18,
                    structHeight: 1.35,
                    structLeading: 0.0,
                    textHeight: 1.35,
                    withBackground: false,
                  )),
            ),
            SizeConfig.customSizedBox(null, 20, null),
            Image.asset(Assets.quran),
            SizeConfig.customSizedBox(null, 10, null),
            SizedBox(
              width: 106,
              height: 36,
              child: FloatingActionButton.extended(
                onPressed: () => Get.to(const AssessmentScreen()),
                backgroundColor: AppColors.buttonColor,
                label: const CustomText(
                    text: 'إبدأ التقييم',
                    withBackground: false,
                    fontSize: 16,
                    color: Color(0xFFFFFFFF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ]),
    );
  }
}
