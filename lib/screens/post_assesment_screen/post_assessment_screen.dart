import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart_3d/pie_chart_3d.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../thirds_screen/thirds_screen.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class PostAssessmentScreen extends StatelessWidget {
  const PostAssessmentScreen({super.key});

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
            ThreeDPieChart(
              data: [
                ChartData(
                    category: '',
                    value: 10,
                    color: GeneralController().dropdownOptions[0]['color']),
                ChartData(
                    category:'',
                    value: 23,
                    color: GeneralController().dropdownOptions[1]['color']),
                ChartData(
                    category:'',
                    value: 47,
                    color: GeneralController().dropdownOptions[2]['color']),
                ChartData(
                    category: '',
                    value: 5,
                    color: GeneralController().dropdownOptions[3]['color']),
                ChartData(
                    category: '',
                    value: 7,
                    color: GeneralController().dropdownOptions[4]['color']),
                ChartData(
                    category: '',
                    value: 8,
                    color: GeneralController().dropdownOptions[5]['color']),
              ],
              options: PieChartOptions(
                height: 250,          
                width: 250,
                radius: 0.6,
                depthDarkness: 3.5,
                ellipseRatio: 0.7,
                showLabels: false,
              ),
            ),
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
                      const CustomText(text: "النصائح", withBackground: false, fontSize: 14)
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
                       const CustomText(text: "صفحة الآيات", withBackground: false, fontSize: 14)
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
