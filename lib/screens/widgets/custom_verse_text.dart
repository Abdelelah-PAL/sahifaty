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
