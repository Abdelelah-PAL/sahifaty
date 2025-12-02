import 'package:connectivity_plus/connectivity_plus.dart';
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

  final List<Map<String, dynamic>> hizbList = [
    {'id': 1, 'name': 'الحزب الأول'},
    {'id': 2, 'name': 'الحزب الثاني'},
    {'id': 3, 'name': 'الحزب الثالث'},
    {'id': 4, 'name': 'الحزب الرابع'},
    {'id': 5, 'name': 'الحزب الخامس'},
    {'id': 6, 'name': 'الحزب السادس'},
    {'id': 7, 'name': 'الحزب السابع'},
    {'id': 8, 'name': 'الحزب الثامن'},
    {'id': 9, 'name': 'الحزب التاسع'},
    {'id': 10, 'name': 'الحزب العاشر'},
    {'id': 11, 'name': 'الحزب الحادي عشر'},
    {'id': 12, 'name': 'الحزب الثاني عشر'},
    {'id': 13, 'name': 'الحزب الثالث عشر'},
    {'id': 14, 'name': 'الحزب الرابع عشر'},
    {'id': 15, 'name': 'الحزب الخامس عشر'},
    {'id': 16, 'name': 'الحزب السادس عشر'},
    {'id': 17, 'name': 'الحزب السابع عشر'},
    {'id': 18, 'name': 'الحزب الثامن عشر'},
    {'id': 19, 'name': 'الحزب التاسع عشر'},
    {'id': 20, 'name': 'الحزب العشرون'},
    {'id': 21, 'name': 'الحزب الحادي والعشرون'},
    {'id': 22, 'name': 'الحزب الثاني والعشرون'},
    {'id': 23, 'name': 'الحزب الثالث والعشرون'},
    {'id': 24, 'name': 'الحزب الرابع والعشرون'},
    {'id': 25, 'name': 'الحزب الخامس والعشرون'},
    {'id': 26, 'name': 'الحزب السادس والعشرون'},
    {'id': 27, 'name': 'الحزب السابع والعشرون'},
    {'id': 28, 'name': 'الحزب الثامن والعشرون'},
    {'id': 29, 'name': 'الحزب التاسع والعشرون'},
    {'id': 30, 'name': 'الحزب الثلاثون'},
    {'id': 31, 'name': 'الحزب الحادي والثلاثون'},
    {'id': 32, 'name': 'الحزب الثاني والثلاثون'},
    {'id': 33, 'name': 'الحزب الثالث والثلاثون'},
    {'id': 34, 'name': 'الحزب الرابع والثلاثون'},
    {'id': 35, 'name': 'الحزب الخامس والثلاثون'},
    {'id': 36, 'name': 'الحزب السادس والثلاثون'},
    {'id': 37, 'name': 'الحزب السابع والثلاثون'},
    {'id': 38, 'name': 'الحزب الثامن والثلاثون'},
    {'id': 39, 'name': 'الحزب التاسع والثلاثون'},
    {'id': 40, 'name': 'الحزب الأربعون'},
    {'id': 41, 'name': 'الحزب الحادي والأربعون'},
    {'id': 42, 'name': 'الحزب الثاني والأربعون'},
    {'id': 43, 'name': 'الحزب الثالث والأربعون'},
    {'id': 44, 'name': 'الحزب الرابع والأربعون'},
    {'id': 45, 'name': 'الحزب الخامس والأربعون'},
    {'id': 46, 'name': 'الحزب السادس والأربعون'},
    {'id': 47, 'name': 'الحزب السابع والأربعون'},
    {'id': 48, 'name': 'الحزب الثامن والأربعون'},
    {'id': 49, 'name': 'الحزب التاسع والأربعون'},
    {'id': 50, 'name': 'الحزب الخمسون'},
    {'id': 51, 'name': 'الحزب الحادي والخمسون'},
    {'id': 52, 'name': 'الحزب الثاني والخمسون'},
    {'id': 53, 'name': 'الحزب الثالث والخمسون'},
    {'id': 54, 'name': 'الحزب الرابع والخمسون'},
    {'id': 55, 'name': 'الحزب الخامس والخمسون'},
    {'id': 56, 'name': 'الحزب السادس والخمسون'},
    {'id': 57, 'name': 'الحزب السابع والخمسون'},
    {'id': 58, 'name': 'الحزب الثامن والخمسون'},
    {'id': 59, 'name': 'الحزب التاسع والخمسون'},
    {'id': 60, 'name': 'الحزب الستون'},
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

  String ayahMarker(int n) => '\u2067\u06DD${toArabicDigits(n)}\u2069';

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

  Future<bool> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    return true;
  }
 }

