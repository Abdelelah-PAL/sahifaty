import 'package:flutter/material.dart';
import 'package:sahifaty/screens/thirds_screen/menu_item.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../widgets/3d_pie_chart.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_dropdown.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: const CustomBackButton(),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              // if (value == 'bookmarks') {
              //   // handle bookmarks
              // } else if (value == 'settings') {
              //   // handle settings
              // }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'bookmarks',
                child: MenuItem(text: "أيقونات الأثلاث"),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: MenuItem(text: "أيقونات الأجزاء"),
              ),
              const PopupMenuItem(
                value: 'about',
                child: MenuItem(text: "أيقونات التقييم"),
              ),
            ],

          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
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
              CustomDropdown(
                third: 1,
                isOpen: openIndex == 1,
                onToggle: () => toggle(1),
              ),
              SizedBox(height: SizeConfig.getProportionalHeight(25)),
              CustomDropdown(
                third: 2,
                isOpen: openIndex == 2,
                onToggle: () => toggle(2),
              ),
              SizedBox(height: SizeConfig.getProportionalHeight(25)),
              CustomDropdown(
                third: 3,
                isOpen: openIndex == 3,
                onToggle: () => toggle(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
