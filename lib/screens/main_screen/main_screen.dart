import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/screens/widgets/custom_hizbs_dropdown.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/evaluations_provider.dart';
import '../../providers/general_provider.dart';
import '../../providers/users_provider.dart';
import '../widgets/3d_pie_chart.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_parts_dropdown.dart';
import '../widgets/custom_thirds_dropdown.dart';
import '../widgets/custom_text.dart';
import '../widgets/user_profile_badge.dart';
import 'widgets/menu_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.comesFirst = false});

  final bool comesFirst;

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
  void initState() {
    // TODO: implement initState
    if (widget.comesFirst) {
      final evaluationsProvider = context.read<EvaluationsProvider>();
      evaluationsProvider.getAllEvaluations();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.comesFirst) {
      SizeConfig().init(context);
    }
    final generalProvider = Provider.of<GeneralProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    final evaluationsProvider = Provider.of<EvaluationsProvider>(context);

    return evaluationsProvider.isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              leading: const CustomBackButton(),
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.list_alt),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: '1',
                        child: MenuItem(
                          text: "أيقونات الأثلاث",
                          onChanged: (v) {
                            if (v) generalProvider.toggleThirdsMenuItem();
                          },
                          index: 1,
                        ),
                      ),
                      PopupMenuItem(
                        value: '2',
                        child: MenuItem(
                          text: "أيقونات الأجزاء",
                          onChanged: (v) {
                            if (v) generalProvider.togglePartsMenuItem();
                          },
                          index: 2,
                        ),
                      ),
                      PopupMenuItem(
                        value: '3',
                        child: MenuItem(
                          text: "أيقونات الأحزاب",
                          onChanged: (v) {
                            if (v) generalProvider.toggleHizbMenuItem();
                          },
                          index: 3,
                        ),
                      ),
                      PopupMenuItem(
                        value: '4',
                        child: MenuItem(
                          text: "أيقونات المواضيع",
                          onChanged: (v) {
                            if (v) generalProvider.toggleSubjectMenuItem();
                          },
                          index: 4,
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: SizeConfig.getProportionalWidth(75),
                right: SizeConfig.getProportionalWidth(75),
                top: SizeConfig.getProportionalHeight(20),
                bottom: SizeConfig.getProportionalHeight(55),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text:
                        'مرحبًا ${usersProvider.selectedUser?.fullName ?? ''}\nهذه هي صحيفتك',
                    structHeight: 3,
                    textAlign: TextAlign.center,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    withBackground: false,
                  ),

                  if (!widget.comesFirst)
                    DonutChart(evaluationsProvider: evaluationsProvider)
                  else
                    SizedBox(height: SizeConfig.getProportionalHeight(250)),

                  SizedBox(height: SizeConfig.getProportionalHeight(20)),

                  // ✅ Dynamically build dropdowns (no nested ListView)
                  ...List.generate(
                    generalProvider.mainScreenView == 1
                        ? 3
                        : generalProvider.mainScreenView == 2
                            ? 30
                            : generalProvider.mainScreenView == 3
                                ? 60
                                : 0,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: generalProvider.mainScreenView == 1
                          ? CustomThirdsDropdown(
                              third: index + 1,
                              isOpen: openIndex == index,
                              onToggle: () => toggle(index),
                            )
                          : generalProvider.mainScreenView == 2
                              ? CustomPartsDropdown(
                                  part: GeneralController().parts[index],
                                  isOpen: openIndex == index,
                                  onToggle: () => toggle(index),
                                )
                              : CustomHizbsButton(
                                  hizb: GeneralController().hizbList[index],
                                ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
