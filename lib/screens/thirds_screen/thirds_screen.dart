import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/providers/general_provider.dart';
import 'package:sahifaty/screens/thirds_screen/widgets/menu_item.dart';
import 'package:sahifaty/screens/widgets/custom_parts_dropdown.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../widgets/3d_pie_chart.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_thirds_dropdown.dart';
import '../widgets/custom_text.dart';

class ThirdsScreen extends StatefulWidget {
  const ThirdsScreen({super.key});

  @override
  State<ThirdsScreen> createState() => _ThirdsScreenState();
}

class _ThirdsScreenState extends State<ThirdsScreen> {
  int? openIndex;

  void toggle(int index) {
    setState(() {
      if (openIndex == index) {
        openIndex = null;
      } else {
        openIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: const CustomBackButton(),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: '1',
                  child: MenuItem(
                    text: "أيقونات الأثلاث",
                    value: generalProvider.thirdsMenuItem,
                    onChanged: (v) {
                      if (v) {
                        generalProvider.toggleThirdsMenuItem();
                      }
                    },
                  ),
                ),
                PopupMenuItem(
                  value: '2',
                  child: MenuItem(
                    text: "أيقونات الأجزاء",
                    value: generalProvider.partsMenuItem,
                    onChanged: (v) {
                      if (v) {
                        generalProvider.togglePartsMenuItem();
                      }
                    },
                  ),
                ),
                PopupMenuItem(
                  value: '3',
                  child: MenuItem(
                    text: "أيقونات التقييم",
                    value: generalProvider.assessmentMenuItem,
                    onChanged: (v) {
                      if (v) {
                        generalProvider.toggleAssessmentMenuItem();
                      }
                    },
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.getProportionalWidth(75),
          right: SizeConfig.getProportionalWidth(75),
          top: SizeConfig.getProportionalHeight(20),
          bottom: SizeConfig.getProportionalHeight(55),
        ),
        child: Column(
          children: [
            const CustomText(
              text: 'مرحبًا أحمد \n هذه هي صحيفتك',
              structHeight: 3,
              textAlign: TextAlign.center,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              withBackground: false,
            ),
            const PieChart3D(
              strongValue: 10,
              revisionValue: 23,
              desireValue: 47,
              easyValue: 5,
              hardValue: 7,
              uncategorizedValue: 8,
            ),
            SizedBox(height: SizeConfig.getProportionalHeight(20)),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: generalProvider.mainScreenView == 1
                    ? 3
                    : generalProvider.mainScreenView == 2
                        ? 30
                        : 0,
                itemBuilder: (ctx, index) {
                  return generalProvider.mainScreenView == 1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: CustomThirdsDropdown(
                            third: index + 1,
                            isOpen: openIndex == index,
                            onToggle: () => toggle(index),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: CustomPartsDropdown(
                            part: index + 1,
                            isOpen: openIndex == index,
                            onToggle: () => toggle(index),
                          ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
