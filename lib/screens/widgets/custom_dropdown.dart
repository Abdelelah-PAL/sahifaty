import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import 'custom_text.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key, required this.third});

  final int third;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  List<String> get dropdownOptions => widget.third == 1
      ? [
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
  ]
      : widget.third == 2
      ? [
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
  ]
      : [
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

  String get hintText => widget.third == 1
      ? "الثلث الأول"
      : widget.third == 2
      ? "الثلث الثاني"
      : "الثلث الثالث";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionalWidth(12),
        vertical: SizeConfig.getProportionalWidth(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          alignment: Alignment.centerRight,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          value: null,
          dropdownColor: Colors.white,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: CustomText(
                    text: hintText,
                    fontSize: 14,
                    color: Colors.white,
                    withBackground: false,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          items: dropdownOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Center(
                child: CustomText(
                  text: option,
                  fontSize: 14,
                  withBackground: false,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
