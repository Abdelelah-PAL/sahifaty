import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/general_provider.dart';
import '../../providers/users_provider.dart';
import '../widgets/3d_pie_chart.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_parts_dropdown.dart';
import '../widgets/custom_thirds_dropdown.dart';
import '../widgets/custom_text.dart';
import 'widgets/menu_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);

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
                    onChanged: (v) {
                      if (v) {
                        generalProvider.toggleThirdsMenuItem();
                      }
                    },
                    index: 1,
                  ),
                ),
                PopupMenuItem(
                  value: '2',
                  child: MenuItem(
                    text: "أيقونات الأجزاء",
                    onChanged: (v) {
                      if (v) {
                        generalProvider.togglePartsMenuItem();
                      }
                    },
                    index: 2,
                  ),
                ),
                PopupMenuItem(
                  value: '3',
                  child: MenuItem(
                    text: "أيقونات التقييم",
                    onChanged: (v) {
                      if (v) {
                        generalProvider.toggleAssessmentMenuItem();
                      }
                    },
                    index: 3,
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
             CustomText(
              text:
                  'مرحبًا ${usersProvider.selectedUser!.fullName} \n هذه هي صحيفتك',
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
