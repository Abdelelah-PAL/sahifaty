import 'package:flutter/material.dart';
import 'package:sahifaty/core/constants/fonts.dart';
import '../../widgets/custom_text.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const MenuItem({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          color: const Color(0xff6B7785),
          fontSize: 14,
          fontWeight: AppFonts.semiBold,
          withBackground: false,
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.green,
          activeTrackColor: Colors.greenAccent,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade400,
        ),
      ],
    );
  }
}
