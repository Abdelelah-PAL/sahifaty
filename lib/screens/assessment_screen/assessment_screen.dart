import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/general_controller.dart';
import '../../core/utils/size_config.dart';
import '../pie_chart_assessment_screen/pie_chart_assessment_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizeConfig.customSizedBox(null, 50, null),
          const CustomText(
            text: 'المستوى الأول',
            fontSize: 16,
            withBackground: true,
            color: Color(0xFFFFFFFF),
          ),
          SizeConfig.customSizedBox(null, 30, null),
          const CustomText(
            text: 'المفروض على المسلم أولًا',
            fontSize: 16,
            withBackground: false,
          ),
          SizeConfig.customSizedBox(null, 30, null),
          SizedBox(
            height: 60,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: isSelected
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0B503D)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: CustomText(
                              text: (index + 1).toString(),
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              withBackground: false,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: CustomText(
                              text: (index + 1).toString(),
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              withBackground: false,
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
          SizeConfig.customSizedBox(null, 30, null),
          Container(
              height: SizeConfig.getProportionalHeight(350),
              width: SizeConfig.getProportionalWidth(236),
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  String? selected = GeneralController().selectedValues[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.getProportionalWidth(8),
                        vertical: SizeConfig.getProportionalHeight(5)),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (GeneralController().selectedValues.containsKey(index)) {
                                GeneralController().selectedValues.remove(index);
                              } else {
                                GeneralController().selectedValues[index] = "";
                              }
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.filter_list_sharp),
                              SizedBox(width: 8),
                              CustomText(
                                text: 'سورة الفاتحة', // keep text unchanged
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                withBackground: false,
                              ),
                              Spacer(),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        if (GeneralController().selectedValues.containsKey(index))
                          Column(
                            children: GeneralController().dropdownOptions.map((option) {
                              bool checked = selected == option['text'];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    GeneralController().selectedValues[index] = option['text'];
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: option['color'],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text: option['text'],
                                          fontSize: 14,
                                          color: Colors.white,
                                          withBackground: false,
                                        ),
                                      ),
                                      Checkbox(
                                        value: checked,
                                        onChanged: (_) {
                                          setState(() {
                                            GeneralController().selectedValues[index] =
                                                option['text'];
                                          });
                                        },
                                        activeColor: Colors.white,
                                        checkColor: option['color'],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  );
                },
              )),
          SizeConfig.customSizedBox(null, 30, null),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionalWidth(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    onPressed: () => Get.to(const PieChartAssessmentScreen()),
                    text: "تخطي",
                    width: 75,
                    height: 35),
                CustomButton(
                    onPressed: () => {},
                    text: "انتقل إلى السؤال التالي",
                    width: 180,
                    height: 35)
              ],
            ),
          )
        ],
      ),
    );
  }
}
