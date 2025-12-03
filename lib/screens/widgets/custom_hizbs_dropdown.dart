import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahifaty/controllers/surahs_controller.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../quran_view/index_page.dart';
import 'custom_text.dart';

class CustomHizbsButton extends StatelessWidget {
  final Map<String, dynamic> hizb;

  const CustomHizbsButton({
    super.key,
    required this.hizb,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Load the surahs that belong to this hizb
        final surahs =
        await SurahsController().loadSurahsByHizb(hizb['id']);

        // Pick first surah (IndexPage only needs hizb when filtering)
        final surah = surahs.first;

        Get.to(
          IndexPage(
            surah: surah,
            filterTypeId: 3, // FilterTypes.hizbs
            hizb: hizb['id'],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionalWidth(12),
          vertical: SizeConfig.getProportionalHeight(4),
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: CustomText(
            text: hizb['name'],
            fontSize: 14,
            color: Colors.white,
            withBackground: false,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
