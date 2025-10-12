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

}
