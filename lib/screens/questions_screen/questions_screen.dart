import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:sahifaty/providers/school_provider.dart';
import 'package:sahifaty/screens/questions_screen/widgets/pagination_bar.dart';
import 'package:sahifaty/screens/sahifa_screen/sahifa_screen.dart';
import '../../controllers/general_controller.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchoolProvider schoolProvider = Provider.of<SchoolProvider>(context);
    AyatProvider ayatProvider = Provider.of<AyatProvider>(context);
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
              'المستوى ${GeneralController().getStringLevel(
                  selectedIndex + 1)}',
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
                      if (ayatProvider.selectedValues.length ==
                          ayatProvider.quickQuestionsAyat.length) {
                        if (page < ayatProvider.quickQuestionsLevelTotalPages) {
                          setState(() {
                            page += 1;
                          });
                          ayatProvider.resetSelections();
                          await ayatProvider.getQuickQuestionsAyatByLevel(
                            selectedIndex + 1,
                            page,
                          );
                          _scrollController.jumpTo(0); // reset scroll
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "عليك تقييم جميع الآيات قبل الانتقال للصفحة التالية"),
                          ),
                        );
                      }
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
                    EvaluationsProvider evaluationsProvider =
                    Provider.of<EvaluationsProvider>(context);
                    Color selectedColor = ayatProvider.getSelectedColor(index);
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.getProportionalWidth(10),
                          vertical: SizeConfig.getProportionalHeight(10)),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.getProportionalHeight(50)),
                      decoration: BoxDecoration(
                        color: selectedColor,
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
                                  text: ayatProvider
                                      .quickQuestionsAyat[index].text,
                                  fontSize: 16,
                                  withBackground: false,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: null,
                                    hint: const Text(''),
                                    items: evaluationsProvider.evaluations
                                        .map<DropdownMenuItem<String>>(
                                            (evaluation) {
                                          return DropdownMenuItem<String>(
                                            value: evaluation.nameAr,
                                            child: Container(
                                              width: double.infinity,
                                              color: evaluation.id! < 6
                                                  ? GeneralController()
                                                  .dropdownOptions[
                                              evaluation.id!]['color']
                                                  : Colors.grey,
                                              padding: const EdgeInsets
                                                  .symmetric(
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
                                        Evaluation eval = evaluationsProvider
                                            .evaluations
                                            .firstWhere((evaluation) =>
                                        evaluation.nameAr == value);

                                        Color color = Colors.grey; // default
                                        if (eval.id != null &&
                                            eval.id! >= 0 &&
                                            eval.id! < GeneralController()
                                                .dropdownOptions.length) {
                                          color = GeneralController()
                                              .dropdownOptions[eval
                                              .id!]['color'];
                                        }

                                        ayatProvider.selectOption(
                                            index, value, color);
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
                    onPressed: () => Get.to(const SahifaScreen()),
                    text: "تخطي",
                    width: 75,
                    height: 35,
                    isDisabled: selectedIndex + 1 ==
                        schoolProvider.quickQuestionsSchool.levels.length
                        ? false
                        : true,
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
                        ayatProvider.resetSelections();
                      },
                      text: "انتقل إلى السؤال التالي",
                      width: 180,
                      height: 35,
                      isDisabled: (page !=
                          ayatProvider.quickQuestionsLevelTotalPages ||
                          ayatProvider.selectedValues.length !=
                              ayatProvider.quickQuestionsAyat.length) ||
                          selectedIndex + 1 ==
                              schoolProvider.quickQuestionsSchool.levels.length
                          ? true
                          : false)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
