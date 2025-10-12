import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahifaty/core/utils/size_config.dart';
import 'package:sahifaty/screens/widgets/custom_text.dart';

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
            height: SizeConfig.getProportionalHeight(436),
            width: SizeConfig.getProportionalWidth(236),
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                     color: const Color(0xD3D3D3D3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Row(
                        textDirection: TextDirection.rtl,
                        children: [
                        Icon(Icons.filter_list_sharp),
                    CustomText(
                      text: 'سورة الفاتحة',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      withBackground: false,
                    ),
                  ],
                ),)
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
