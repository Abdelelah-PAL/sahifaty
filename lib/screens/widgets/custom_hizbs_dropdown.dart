import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahifaty/controllers/surahs_controller.dart';
import 'package:sahifaty/models/surah.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../quran_view/index_page.dart';
import 'custom_text.dart';
import 'package:quran/quran.dart' as quran;

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
            filterTypeId: 3,
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
          child: FutureBuilder<List<Surah>>(
            future: SurahsController().loadSurahsByHizb(hizb['id']),
            builder: (context, snapshot) {
              String displayText = hizb['name'];
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final surahNames = snapshot.data!.map((e) => Get.locale?.languageCode == 'ar' ? quran.getSurahNameArabic(e.id) : quran.getSurahName(e.id)).join('، ');
                displayText = '$displayText\n($surahNames)';
              }
              return CustomText(
                text: displayText,
                fontSize: 14,
                color: Colors.white,
                withBackground: false,
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ),
    );
  }
}
