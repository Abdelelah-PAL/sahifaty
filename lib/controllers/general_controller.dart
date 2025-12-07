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

  final List<Map<String, dynamic>> quranSurahs = [
    {'id': 1, 'name': 'الفاتحة'},
    {'id': 2, 'name': 'البقرة'},
    {'id': 3, 'name': 'آل عمران'},
    {'id': 4, 'name': 'النساء'},
    {'id': 5, 'name': 'المائدة'},
    {'id': 6, 'name': 'الأنعام'},
    {'id': 7, 'name': 'الأعراف'},
    {'id': 8, 'name': 'الأنفال'},
    {'id': 9, 'name': 'التوبة'},
    {'id': 10, 'name': 'يونس'},
    {'id': 11, 'name': 'هود'},
    {'id': 12, 'name': 'يوسف'},
    {'id': 13, 'name': 'الرعد'},
    {'id': 14, 'name': 'إبراهيم'},
    {'id': 15, 'name': 'الحجر'},
    {'id': 16, 'name': 'النحل'},
    {'id': 17, 'name': 'الإسراء'},
    {'id': 18, 'name': 'الكهف'},
    {'id': 19, 'name': 'مريم'},
    {'id': 20, 'name': 'طه'},
    {'id': 21, 'name': 'الأنبياء'},
    {'id': 22, 'name': 'الحج'},
    {'id': 23, 'name': 'المؤمنون'},
    {'id': 24, 'name': 'النور'},
    {'id': 25, 'name': 'الفرقان'},
    {'id': 26, 'name': 'الشعراء'},
    {'id': 27, 'name': 'النمل'},
    {'id': 28, 'name': 'القصص'},
    {'id': 29, 'name': 'العنكبوت'},
    {'id': 30, 'name': 'الروم'},
    {'id': 31, 'name': 'لقمان'},
    {'id': 32, 'name': 'السجدة'},
    {'id': 33, 'name': 'الأحزاب'},
    {'id': 34, 'name': 'سبأ'},
    {'id': 35, 'name': 'فاطر'},
    {'id': 36, 'name': 'يس'},
    {'id': 37, 'name': 'الصافات'},
    {'id': 38, 'name': 'ص'},
    {'id': 39, 'name': 'الزمر'},
    {'id': 40, 'name': 'غافر'},
    {'id': 41, 'name': 'فصلت'},
    {'id': 42, 'name': 'الشورى'},
    {'id': 43, 'name': 'الزخرف'},
    {'id': 44, 'name': 'الدخان'},
    {'id': 45, 'name': 'الجاثية'},
    {'id': 46, 'name': 'الأحقاف'},
    {'id': 47, 'name': 'محمد'},
    {'id': 48, 'name': 'الفتح'},
    {'id': 49, 'name': 'الحجرات'},
    {'id': 50, 'name': 'ق'},
    {'id': 51, 'name': 'الذاريات'},
    {'id': 52, 'name': 'الطور'},
    {'id': 53, 'name': 'النجم'},
    {'id': 54, 'name': 'القمر'},
    {'id': 55, 'name': 'الرحمن'},
    {'id': 56, 'name': 'الواقعة'},
    {'id': 57, 'name': 'الحديد'},
    {'id': 58, 'name': 'المجادلة'},
    {'id': 59, 'name': 'الحشر'},
    {'id': 60, 'name': 'الممتحنة'},
    {'id': 61, 'name': 'الصف'},
    {'id': 62, 'name': 'الجمعة'},
    {'id': 63, 'name': 'المنافقون'},
    {'id': 64, 'name': 'التغابن'},
    {'id': 65, 'name': 'الطلاق'},
    {'id': 66, 'name': 'التحريم'},
    {'id': 67, 'name': 'الملك'},
    {'id': 68, 'name': 'القلم'},
    {'id': 69, 'name': 'الحاقة'},
    {'id': 70, 'name': 'المعارج'},
    {'id': 71, 'name': 'نوح'},
    {'id': 72, 'name': 'الجن'},
    {'id': 73, 'name': 'المزمل'},
    {'id': 74, 'name': 'المدثر'},
    {'id': 75, 'name': 'القيامة'},
    {'id': 76, 'name': 'الإنسان'},
    {'id': 77, 'name': 'المرسلات'},
    {'id': 78, 'name': 'النبأ'},
    {'id': 79, 'name': 'النازعات'},
    {'id': 80, 'name': 'عبس'},
    {'id': 81, 'name': 'التكوير'},
    {'id': 82, 'name': 'الانفطار'},
    {'id': 83, 'name': 'المطففين'},
    {'id': 84, 'name': 'الانشقاق'},
    {'id': 85, 'name': 'البروج'},
    {'id': 86, 'name': 'الطارق'},
    {'id': 87, 'name': 'الأعلى'},
    {'id': 88, 'name': 'الغاشية'},
    {'id': 89, 'name': 'الفجر'},
    {'id': 90, 'name': 'البلد'},
    {'id': 91, 'name': 'الشمس'},
    {'id': 92, 'name': 'الليل'},
    {'id': 93, 'name': 'الضحى'},
    {'id': 94, 'name': 'الشرح'},
    {'id': 95, 'name': 'التين'},
    {'id': 96, 'name': 'العلق'},
    {'id': 97, 'name': 'القدر'},
    {'id': 98, 'name': 'البينة'},
    {'id': 99, 'name': 'الزلزلة'},
    {'id': 100, 'name': 'العاديات'},
    {'id': 101, 'name': 'القارعة'},
    {'id': 102, 'name': 'التكاثر'},
    {'id': 103, 'name': 'العصر'},
    {'id': 104, 'name': 'الهمزة'},
    {'id': 105, 'name': 'الفيل'},
    {'id': 106, 'name': 'قريش'},
    {'id': 107, 'name': 'الماعون'},
    {'id': 108, 'name': 'الكوثر'},
    {'id': 109, 'name': 'الكافرون'},
    {'id': 110, 'name': 'النصر'},
    {'id': 111, 'name': 'المسد'},
    {'id': 112, 'name': 'الإخلاص'},
    {'id': 113, 'name': 'الفلق'},
    {'id': 114, 'name': 'الناس'},
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

  String getSurahNameByNumber(int number) {
    final surah = quranSurahs.firstWhere(
          (s) => s['id'] == number,
      orElse: () => {'name': 'غير موجود'},
    );
    return surah['name'];
  }
 }

