import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/controllers/evaluations_controller.dart';
import 'package:sahifaty/models/ayat.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:sahifaty/providers/school_provider.dart';
import 'package:sahifaty/providers/users_provider.dart';
import 'package:sahifaty/screens/first_pie_chart_screen/first_pie_chart_screen.dart';
import 'package:sahifaty/screens/questions_screen/widgets/pagination_bar.dart';
import '../../controllers/general_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../models/evaluation.dart';
import '../../providers/ayat_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int selectedIndex = 0;
  int page = 1;
  final Map<int, Color> dropdownColors = {
    0: AppColors.uncategorizedColor,
    1: AppColors.strongColor,
    2: AppColors.revisionColor,
    3: AppColors.desireColor,
    4: AppColors.easyColor,
    5: AppColors.hardColor,
    67: AppColors.uncategorizedColor,
  };

  final ScrollController _scrollController = ScrollController();
  final Map<int, Color> _selectedColors = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchoolProvider schoolProvider = Provider.of<SchoolProvider>(context);
    AyatProvider ayatProvider = Provider.of<AyatProvider>(context);
    EvaluationsProvider evaluationsProvider =
        Provider.of<EvaluationsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.getProportionalHeight(20),
            horizontal: SizeConfig.getProportionalHeight(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.customSizedBox(null, 50, null),
            CustomText(
              text:
                  'المستوى ${GeneralController().getStringLevel(selectedIndex + 1)}',
              fontSize: 16,
              withBackground: true,
              color: const Color(0xFFFFFFFF),
            ),
            SizeConfig.customSizedBox(null, 30, null),
            CustomText(
              text: schoolProvider.quickQuestionsSchool.levels[selectedIndex],
              fontSize: 16,
              withBackground: false,
            ),
            SizeConfig.customSizedBox(null, 30, null),
            SizedBox(
              height: SizeConfig.getProportionalHeight(60),
              child: Center(
                child: PaginationBar(
                  currentPage: page,
                  totalPages: ayatProvider.quickQuestionsLevelTotalPages,
                  onNext: () async {
                    // if (ayatProvider.evaluatedVersesCount ==
                    //         ayatProvider.quickQuestionsAyat.length &&
                    //     page < ayatProvider.quickQuestionsLevelTotalPages) {
                    ayatProvider.resetEvaluatedVersesCount();
                    setState(() {
                      page += 1;
                      _selectedColors.clear();
                    });
                    await ayatProvider.getQuickQuestionsAyatByLevel(
                      selectedIndex + 1,
                      page,
                    );
                    _scrollController.jumpTo(0); // reset scroll
                    //   }
                    //   else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text(
                    //             "عليك تقييم جميع الآيات قبل الانتقال للصفحة التالية"),
                    //       ),
                    //     );
                    //   }
                    // },
                  },
                  onPrevious: () async {
                    // if (ayatProvider.evaluatedVersesCount ==
                    //         ayatProvider.quickQuestionsAyat.length &&
                    //     page < ayatProvider.quickQuestionsLevelTotalPages) {
                    ayatProvider.resetEvaluatedVersesCount();
                    setState(() {
                      page -= 1;
                      _selectedColors.clear();
                    });
                    await ayatProvider.getQuickQuestionsAyatByLevel(
                      selectedIndex + 1,
                      page,
                    );
                    _scrollController.jumpTo(0); // reset scroll
                    //   }
                    //   else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text(
                    //             "عليك تقييم جميع الآيات قبل الانتقال للصفحة التالية"),
                    //       ),
                    //     );
                    //   }
                    // },
                  },

                ),
                // child: ListView.builder(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.horizontal,
                //   itemCount: ayatProvider.quickQuestionsLevelTotalPages,
                //   itemBuilder: (context, index) {
                //     bool isSelected = page == index + 1;
                //     return GestureDetector(
                //       onTap: () async {
                //         if (ayatProvider.selectedValues.length ==
                //             ayatProvider.quickQuestionsAyat.length) {
                //           if (index + 1 < page) return;
                //           setState(() {
                //             page = index + 1;
                //           });
                //           ayatProvider.resetSelections();
                //           await ayatProvider.getQuickQuestionsAyatByLevel(
                //             selectedIndex + 1,
                //             page,
                //           );
                //           _scrollController.jumpTo(0);
                //         } else {
                //           ScaffoldMessenger.of(context).showSnackBar(
                //             const SnackBar(
                //                 content: Text(
                //                     "عليك تقييم جميع الآيات قبل الانتقال للصفحة التالية")),
                //           );
                //         }
                //       },
                //       child: Container(
                //         margin: const EdgeInsets.symmetric(
                //             horizontal: 4, vertical: 6),
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 8, vertical: 3),
                //         decoration: BoxDecoration(
                //           color: isSelected
                //               ? const Color(0xFF0B503D)
                //               : Colors.transparent,
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(color: Colors.grey),
                //         ),
                //         child: CustomText(
                //           text: (index + 1).toString(),
                //           fontSize: 12,
                //           color: isSelected ? Colors.white : Colors.black,
                //           fontWeight:
                //               isSelected ? FontWeight.bold : FontWeight.normal,
                //           withBackground: false,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
            SizeConfig.customSizedBox(null, 30, null),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: ayatProvider.quickQuestionsAyat.length,
                  itemBuilder: (context, index) {
                    Ayat verse = ayatProvider.quickQuestionsAyat[index];

                    // 1️⃣ Initial color from backend evaluation
                    Color initialColor =
                        verse.userEvaluation?.evaluation?.id != null
                            ? dropdownColors[
                                    verse.userEvaluation!.evaluation!.id!] ??
                                Colors.grey
                            : Colors.grey;

                    // 2️⃣ If user selected a new color locally → use it
                    Color containerColor =
                        _selectedColors[index] ?? initialColor;

                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.getProportionalWidth(10),
                          vertical: SizeConfig.getProportionalHeight(10)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.getProportionalHeight(50)),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: verse.text,
                                  fontSize: 16,
                                  withBackground: false,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: null,
                                    items: evaluationsProvider.evaluations
                                        .map((evaluation) {
                                      final color = evaluation.id != null &&
                                              evaluation.id! < 6
                                          ? GeneralController().dropdownOptions[
                                              evaluation.id!]['color']
                                          : Colors.grey;
                                      return DropdownMenuItem<String>(
                                        value: evaluation.nameAr,
                                        child: Container(
                                          width: double.infinity,
                                          color: color,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          child: CustomText(
                                            text: evaluation.nameAr,
                                            fontSize: 14,
                                            color: Colors.white,
                                            withBackground: false,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        Evaluation evaluation =
                                            evaluationsProvider.evaluations
                                                .firstWhere(
                                                    (e) => e.nameAr == value);

                                        final newColor =
                                            evaluation.id != null &&
                                                    evaluation.id! < 6
                                                ? GeneralController()
                                                        .dropdownOptions[
                                                    evaluation.id!]['color']
                                                : Colors.grey;
                                        // Save locally
                                        setState(() {
                                          _selectedColors[index] = newColor;
                                        });
                                        EvaluationsController().sendEvaluation(
                                            verse,
                                            evaluation,
                                            evaluationsProvider,
                                            ayatProvider);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizeConfig.customSizedBox(null, 15, null),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionalWidth(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () async {
                      UsersProvider usersProvider =
                          context.read<UsersProvider>();
                      await evaluationsProvider
                          .getQuranChartData(usersProvider.selectedUser!.id);
                      Get.to(const FirstPieChartScreen());
                    },
                    text: "تخطي",
                    width: 75,
                    height: 35,
                    isDisabled: false,
                    // isDisabled: selectedIndex + 1 ==
                    //         schoolProvider.quickQuestionsSchool.levels.length
                    //     ? false
                    //     : true,
                  ),
                  CustomButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                        );
                        setState(() {
                          page = 1;
                          selectedIndex = selectedIndex + 1;
                        });
                        ayatProvider.getQuickQuestionsAyatByLevel(
                            selectedIndex + 1, 1);
                        ayatProvider.resetEvaluatedVersesCount();
                        _selectedColors.clear();
                      },
                      text: "انتقل إلى السؤال التالي",
                      width: 180,
                      height: 35,
                      isDisabled:
                          // (page != ayatProvider.quickQuestionsLevelTotalPages ||
                          //             ayatProvider.evaluatedVersesCount <
                          //                 ayatProvider
                          //                     .quickQuestionsAyat.length) ||
                          //         selectedIndex + 1 ==
                          //             schoolProvider
                          //                 .quickQuestionsSchool.levels.length
                          //     ? true
                          //     :
                          false
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
