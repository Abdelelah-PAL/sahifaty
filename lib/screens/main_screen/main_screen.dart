import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/controllers/filter_types.dart';
import 'package:sahifaty/screens/widgets/custom_hizbs_dropdown.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/evaluations_provider.dart';
import '../../providers/general_provider.dart';
import '../../providers/surahs_provider.dart';
import '../../providers/users_provider.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_parts_dropdown.dart';
import '../widgets/custom_thirds_dropdown.dart';
import '../widgets/custom_text.dart';
import 'widgets/menu_item.dart';
import '../widgets/no_pop_scope.dart';

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
    final surahsProvider = Provider.of<SurahsProvider>(context);

    return evaluationsProvider.isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : NoPopScope(
            child: Scaffold(
              appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppBar(
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
                              text: "thirds_icons".tr,
                              onChanged: (v) {
                                generalProvider.toggleThirdsMenuItem();
                              },
                              index: 1,
                            ),
                          ),
                          PopupMenuItem(
                            value: '2',
                            child: MenuItem(
                              text: "parts_icons".tr,
                              onChanged: (v) {
                                generalProvider.togglePartsMenuItem();
                              },
                              index: 2,
                            ),
                          ),
                          PopupMenuItem(
                            value: '3',
                            child: MenuItem(
                              text: "hizbs_icons".tr,
                              onChanged: (v) {
                                // 1️⃣Switch view
                                generalProvider.toggleHizbMenuItem();

                                // 2️ Close popup first
                                if (generalProvider.hizbsMenuItem) {
                                  Navigator.pop(context);

                                  // 3️⃣ Start loading after frame
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    context
                                        .read<SurahsProvider>()
                                        .loadAllHizbSurahs(
                                            GeneralController().hizbList);
                                  });
                                }
                              },
                              index: 3,
                            ),
                          ),

                          // PopupMenuItem(
                          //   value: '4',
                          //   child: MenuItem(
                          //     text: "topics_icons".tr,
                          //     onChanged: (v) {
                          //       if (v) generalProvider.toggleSubjectMenuItem();
                          //     },
                          //     index: 4,
                          //   ),
                          // ),
                        ];
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: SizeConfig.getProportionalWidth(75),
                right: SizeConfig.getProportionalWidth(35),
                top: SizeConfig.getProportionalHeight(20),
                bottom: SizeConfig.getProportionalHeight(55),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text:
                        '${"well_done".tr} ${usersProvider.selectedUser?.fullName ?? ''}',
                    structHeight: 3,
                    textAlign: TextAlign.center,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    withBackground: false,
                  ),

                  if (!widget.comesFirst)

                    BarChartWidget(evaluationsProvider: evaluationsProvider)
                  else
                    SizedBox(height: SizeConfig.getProportionalHeight(250)),

                  SizedBox(height: SizeConfig.getProportionalHeight(20)),

                  if (generalProvider.mainScreenView == FilterTypes.hizbs &&
                      surahsProvider.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (generalProvider.mainScreenView == FilterTypes.hizbs)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 60,
                      itemBuilder: (context, index) => CustomHizbsButton(
                        hizb: GeneralController().hizbList[index],
                      ),
                    )
                  else
                    ...List.generate(
                      generalProvider.mainScreenView == FilterTypes.thirds
                          ? 3
                          : generalProvider.mainScreenView == FilterTypes.parts
                              ? 30
                              : 0,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: generalProvider.mainScreenView == FilterTypes.thirds
                            ? CustomThirdsDropdown(
                                third: index + 1,
                                isOpen: openIndex == index,
                                onToggle: () => toggle(index),
                              )
                            : CustomPartsDropdown(
                                part: GeneralController().parts[index],
                                isOpen: openIndex == index,
                                onToggle: () => toggle(index),
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
