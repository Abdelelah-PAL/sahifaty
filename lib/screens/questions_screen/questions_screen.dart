import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/providers/general_provider.dart';
import 'package:sahifaty/screens/sahifa_screen/sahifa_screen.dart';
import '../../controllers/general_controller.dart';
import '../../core/utils/size_config.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int? selectedIndex = 0;
  List<String> surahs = ['الفاتحة', 'الإخلاص', 'الكوثر', 'الأعلى', 'الناس'];

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
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                Color selectedColor = context.watch<GeneralProvider>().getSelectedColor(index);
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getProportionalWidth(8),
                    vertical: SizeConfig.getProportionalHeight(5),
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list_sharp),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: null,
                            hint: CustomText(
                              text: surahs[index],
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              withBackground: false,
                            ),
                            items: GeneralController().dropdownOptions.map<DropdownMenuItem<String>>((option) {
                              return DropdownMenuItem<String>(
                                value: option['text'],
                                child: Container(
                                  width: double.infinity,
                                  color: option['color'],
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                  child: CustomText(
                                    text: option['text'],
                                    fontSize: 14,
                                    color: Colors.white,
                                    withBackground: false,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                Color color = GeneralController()
                                    .dropdownOptions
                                    .firstWhere((option) => option['text'] == value)['color'];
                                context.read<GeneralProvider>().selectOption(index, value, color);
                              }
                            },
                            icon: const Icon(Icons.arrow_drop_down),
                            dropdownColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizeConfig.customSizedBox(null, 30, null),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionalWidth(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    onPressed: () => Get.to(const SahifaScreen()),
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
