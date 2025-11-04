import 'dart:ui';

import '../core/constants/colors.dart';

class GeneralController {
  // Dropdown options with text and associated color
  final List<Map<String, dynamic>> dropdownOptions = [
    {'id': 0, 'color': AppColors.strongColor},
    {'id': 1, 'color': AppColors.revisionColor},
    {'id': 2, 'color': AppColors.desireColor},
    {'id': 3, 'color': AppColors.easyColor},
    {'id': 4, 'color': AppColors.hardColor},
    {'id': 5, 'color': AppColors.uncategorizedColor},
  ];

  final List<String> firstThird = [
    'الجزء الأول',
    'الجزء الثاني',
    'الجزء الثالث',
    'الجزء الرابع',
    'الجزء الخامس',
    'الجزء السادس',
    'الجزء السابع',
    'الجزء الثامن',
    'الجزء التاسع',
    'الجزء العاشر',
  ];
  final List<String> secondThird = [
    'الجزء الحادي عشر',
    'الجزء الثاني عشر',
    'الجزء الثالث عشر',
    'الجزء الرابع عشر',
    'الجزء الخامس عشر',
    'الجزء السادس عشر',
    'الجزء السابع عشر',
    'الجزء الثامن عشر',
    'الجزء التاسع عشر',
    'الجزء العشرون',
  ];
  final List<String> thirdThird = [
    'الجزء الحادي والعشرين',
    'الجزء الثاني والعشرين',
    'الجزء الثالث والعشرين',
    'الجزء الرابع والعشرين',
    'الجزء الخامس والعشرين',
    'الجزء السادس والعشرين',
    'الجزء السابع والعشرين',
    'الجزء الثامن والعشرين',
    'الجزء التاسع والعشرين',
    'الجزء الثلاثون',
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
}
