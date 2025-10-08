import 'package:flutter/material.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/fonts.dart';
import '../../core/utils/size_config.dart';
import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   goToNextView();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.customSizedBox(null, 170, null),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'أهلًا بك في صحيفتي!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.titleFont,
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  width: 320,
                  child: Text(
                    'سنقوم بطرح بعض الأسئلة السريعة\nلتكوين صحيفتك المبدئية.\nستبنى هذه الصحيفة على مدى إلمامك بالقرآن الكريم ',
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
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(Assets.logo),
            const SizedBox(
              height: 50,
            ),
             SizedBox(
              width: 106,
              height: 36,
              child: FloatingActionButton.extended(
                onPressed: null,
                backgroundColor: AppColors.buttonColor,
                label: const Text(
                  'إبدأ التقييم',
                  style:
                      TextStyle(color: AppColors.backgroundColor, fontSize: 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ]),
    );
  }
}

// void goToNextView() {
//   Future.delayed(const Duration(seconds: 2), () {
//     Get.to(() => const OnBoardingScreen(), transition: Transition.fade);
//   });
