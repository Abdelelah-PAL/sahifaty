import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../providers/evaluations_provider.dart';
import '../../providers/surahs_provider.dart';
import '../../providers/users_provider.dart';
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
    final surahsProvider = context.watch<SurahsProvider>();
    final evaluationsProvider =
    context.read<EvaluationsProvider>();

    final usersProvider =
    context.read<UsersProvider>();
    final surahs =
        surahsProvider.hizbSurahs[hizb['id']] ?? [];

    final surahNames = surahs
        .map((e) => quran.getSurahNameArabic(e.id))
        .join('، ');

    final displayText =
        '${hizb['name']}\n($surahNames)';

    return GestureDetector(
      onTap: () {
        final surah = surahs.first;

        Get.to(
          IndexPage(
            surah: surah,
            filterTypeId: 3,
            hizb: hizb['id'],
          ),
        )?.then((_) {
          evaluationsProvider.getQuranChartData(
              usersProvider.selectedUser!.id);
        });
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
            text: displayText,
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

