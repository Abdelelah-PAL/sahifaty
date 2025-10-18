import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/fonts.dart';

class CustomVerseText extends StatelessWidget {
  final String text;
  final int category;
  final Color backgroundColor;

  const CustomVerseText({
    super.key,
    required this.text,
    required this.category,
  }) : backgroundColor = (
      category == 1 ? AppColors.strongColor :
      category == 2 ? AppColors.revisionColor :
      category == 3 ? AppColors.desireColor :
      category == 4 ? AppColors.easyColor :
      category == 5 ? AppColors.hardColor :
      category == 6 ? AppColors.uncategorizedColor :
      AppColors.uncategorizedColor
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: false,
            onChanged: (val) {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppColors.whiteFontColor,
            checkColor: backgroundColor,
          ),
          Flexible(
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
              style:  TextStyle(
                fontSize: 14,
                height: 2,
                color: AppColors.whiteFontColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.versesFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomVerseText2 extends StatelessWidget {
  final String text;
  final int category;
  final int verseNumber; // 🔹 added
  final Color backgroundColor;

  const CustomVerseText2({
    super.key,
    required this.text,
    required this.category,
    required this.verseNumber, // 🔹 added
  }) : backgroundColor = (
      category == 1 ? AppColors.strongColor :
      category == 2 ? AppColors.revisionColor :
      category == 3 ? AppColors.desireColor :
      category == 4 ? AppColors.easyColor :
      category == 5 ? AppColors.hardColor :
      category == 6 ? AppColors.uncategorizedColor :
      AppColors.uncategorizedColor
  );

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          // 🔹 Verse text
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 20,
              height: 2.1,
              color: backgroundColor,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.versesFont,
            ),
          ),

          // 🔹 Verse number (Quran style)
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE0E0E0),
                ),
                child: Text(
                  _toArabicNumber(verseNumber),
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontFamily: 'Amiri', // or your Arabic font
                  ),
                ),
              ),
            ),
          ),

          // 🔹 Optional small space after the verse
          const TextSpan(text: ' '),
        ],
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
    );
  }

  /// Converts an integer (e.g., 12) to Arabic numerals (e.g., ١٢)
  String _toArabicNumber(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join('');
  }
}
