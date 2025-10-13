import '../core/constants/colors.dart';

class GeneralController {
  // Store selected values for each index
  final Map<int, String> selectedValues = {};

  // Dropdown options with text and associated color
  final List<Map<String, dynamic>> dropdownOptions = [
    {'text': 'متمكن', 'color': AppColors.strongColor},
    {'text': 'للمراجعة', 'color': AppColors.revisionColor},
    {'text': 'رغبة', 'color': AppColors.desireColor},
    {'text': 'سهل', 'color': AppColors.easyColor},
    {'text': 'صعب', 'color': AppColors.hardColor},
    {'text': 'غير مصنف', 'color': AppColors.uncategorizedColor},
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
}
