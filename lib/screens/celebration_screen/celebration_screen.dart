import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart_3d/pie_chart_3d.dart';
import 'package:sahifaty/screens/widgets/3d_pie_chart.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../thirds_screen/thirds_screen.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class CelebrationScreen extends StatelessWidget {
  const CelebrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.getProportionalWidth(75),
            right: SizeConfig.getProportionalWidth(75),
            top: SizeConfig.getProportionalHeight(50),
            bottom: SizeConfig.getProportionalHeight(55)),
        child: Column(
          children: [
            const CustomText(
              text: 'مرحبًا أحمد \n هذه هي صحيفتك',
              structHeight: 3,
              textAlign: TextAlign.center,
              fontSize: 24,
              withBackground: false,
            ),
            const PieChart3D(
                strongValue: 10,
                revisionValue: 23,
                desireValue: 47,
                easyValue: 5,
                hardValue: 7,
                uncategorizedValue: 8),
            SizedBox(
              height: SizeConfig.getProportionalHeight(100),
            ),
            CustomButton(
                onPressed: () => {Get.to(const ThirdsScreen())},
                text: 'ابدأ بتحسين مستواك',
                width: 170,
                height: 35),
            SizedBox(
              height: SizeConfig.getProportionalHeight(10),
            ),
            SizedBox(
              width: SizeConfig.getProportionalWidth(170),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                          onPressed: () => {},
                          icon: Icons.notes_outlined,
                          width: 40,
                          height: 35),
                      const CustomText(
                          text: "النصائح", withBackground: false, fontSize: 14)
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomButton(
                          onPressed: () => {},
                          icon: Icons.check_circle_outline_outlined,
                          width: 40,
                          height: 35),
                      const CustomText(
                          text: "صفحة الآيات",
                          withBackground: false,
                          fontSize: 14)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
