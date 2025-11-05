import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class GeneralController {
  // Dropdown options with text and associated color
  final List<Map<String, dynamic>> dropdownOptions = [
    {'id': 0, 'color': AppColors.uncategorizedColor},
    {'id': 1, 'color': AppColors.strongColor},
    {'id': 2, 'color': AppColors.revisionColor},
    {'id': 3, 'color': AppColors.desireColor},
    {'id': 4, 'color': AppColors.easyColor},
    {'id': 5, 'color': AppColors.hardColor},
    {'id': 67, 'color': AppColors.uncategorizedColor},
  ];

  final List<Map<String, dynamic>> parts = [
    {'id': 1, 'name': 'الجزء الأول'},
    {'id': 2, 'name': 'الجزء الثاني'},
    {'id': 3, 'name': 'الجزء الثالث'},
    {'id': 4, 'name': 'الجزء الرابع'},
    {'id': 5, 'name': 'الجزء الخامس'},
    {'id': 6, 'name': 'الجزء السادس'},
    {'id': 7, 'name': 'الجزء السابع'},
    {'id': 8, 'name': 'الجزء الثامن'},
    {'id': 9, 'name': 'الجزء التاسع'},
    {'id': 10, 'name': 'الجزء العاشر'},
    {'id': 11, 'name': 'الجزء الحادي عشر'},
    {'id': 12, 'name': 'الجزء الثاني عشر'},
    {'id': 13, 'name': 'الجزء الثالث عشر'},
    {'id': 14, 'name': 'الجزء الرابع عشر'},
    {'id': 15, 'name': 'الجزء الخامس عشر'},
    {'id': 16, 'name': 'الجزء السادس عشر'},
    {'id': 17, 'name': 'الجزء السابع عشر'},
    {'id': 18, 'name': 'الجزء الثامن عشر'},
    {'id': 19, 'name': 'الجزء التاسع عشر'},
    {'id': 20, 'name': 'الجزء العشرون'},
    {'id': 21, 'name': 'الجزء الحادي والعشرين'},
    {'id': 22, 'name': 'الجزء الثاني والعشرين'},
    {'id': 23, 'name': 'الجزء الثالث والعشرين'},
    {'id': 24, 'name': 'الجزء الرابع والعشرين'},
    {'id': 25, 'name': 'الجزء الخامس والعشرين'},
    {'id': 26, 'name': 'الجزء السادس والعشرين'},
    {'id': 27, 'name': 'الجزء السابع والعشرين'},
    {'id': 28, 'name': 'الجزء الثامن والعشرين'},
    {'id': 29, 'name': 'الجزء التاسع والعشرين'},
    {'id': 30, 'name': 'الجزء الثلاثون'},
  ];



  final List<Map<String, dynamic>> firstThird = [
    {'id': 1, 'name': 'الجزء الأول'},
    {'id': 2, 'name': 'الجزء الثاني'},
    {'id': 3, 'name': 'الجزء الثالث'},
    {'id': 4, 'name': 'الجزء الرابع'},
    {'id': 5, 'name': 'الجزء الخامس'},
    {'id': 6, 'name': 'الجزء السادس'},
    {'id': 7, 'name': 'الجزء السابع'},
    {'id': 8, 'name': 'الجزء الثامن'},
    {'id': 9, 'name': 'الجزء التاسع'},
    {'id': 10, 'name': 'الجزء العاشر'},
  ];
  final List<Map<String, dynamic>> secondThird = [
    {'id': 11, 'name': 'الجزء الحادي عشر'},
    {'id': 12, 'name': 'الجزء الثاني عشر'},
    {'id': 13, 'name': 'الجزء الثالث عشر'},
    {'id': 14, 'name': 'الجزء الرابع عشر'},
    {'id': 15, 'name': 'الجزء الخامس عشر'},
    {'id': 16, 'name': 'الجزء السادس عشر'},
    {'id': 17, 'name': 'الجزء السابع عشر'},
    {'id': 18, 'name': 'الجزء الثامن عشر'},
    {'id': 19, 'name': 'الجزء التاسع عشر'},
    {'id': 20, 'name': 'الجزء العشرون'},
  ];
  final List<Map<String, dynamic>> thirdThird = [
    {'id': 21, 'name': 'الجزء الحادي والعشرين'},
    {'id': 22, 'name': 'الجزء الثاني والعشرين'},
    {'id': 23, 'name': 'الجزء الثالث والعشرين'},
    {'id': 24, 'name': 'الجزء الرابع والعشرين'},
    {'id': 25, 'name': 'الجزء الخامس والعشرين'},
    {'id': 26, 'name': 'الجزء السادس والعشرين'},
    {'id': 27, 'name': 'الجزء السابع والعشرين'},
    {'id': 28, 'name': 'الجزء الثامن والعشرين'},
    {'id': 29, 'name': 'الجزء التاسع والعشرين'},
    {'id': 30, 'name': 'الجزء الثلاثون'},
  ];

  String toArabicDigits(int n) => n
      .toString()
      .replaceAll('0', '٠')
      .replaceAll('1', '١')
      .replaceAll('2', '٢')
      .replaceAll('3', '٣')
      .replaceAll('4', '٤')
      .replaceAll('5', '٥')
      .replaceAll('6', '٦')
      .replaceAll('7', '٧')
      .replaceAll('8', '٨')
      .replaceAll('9', '٩');

  String ayahMarker(int n) => '\u2067\u06DD${toArabicDigits(n + 1)}\u2069';

  Color getColorFromCategory(int category) {
    switch (category) {
      case 0:
        return AppColors.uncategorizedColor;
      case 1:
        return AppColors.strongColor;
      case 2:
        return AppColors.revisionColor;
      case 3:
        return AppColors.desireColor;
      case 4:
        return AppColors.easyColor;
      case 5:
        return AppColors.hardColor;
      default:
        return AppColors.uncategorizedColor;
    }
  }

  String toArabicNumber(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join('');
  }

  Color getColorForOption(String? text) {
    if (text == null) return AppColors.uncategorizedColor;
    return dropdownOptions.firstWhere(
      (opt) => opt['text'] == text,
      orElse: () => {'color': AppColors.uncategorizedColor},
    )['color'];
  }

  String getStringLevel(level) {
    String stringLevel = '';
    switch (level) {
      case 1:
        stringLevel = "الأول";
        break;
      case 2:
        stringLevel = "الثاني";
        break;
      case 3:
        stringLevel = "الثالث";
        break;
      case 4:
        stringLevel = "الرابع";
        break;
      case 5:
        stringLevel = "الخامس";
        break;
      case 6:
        stringLevel = "السادس";
        break;
    }
    return stringLevel;
  }

  Color getOnColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
