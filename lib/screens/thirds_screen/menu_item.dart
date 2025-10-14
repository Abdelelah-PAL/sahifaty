import 'package:flutter/material.dart';
import 'package:sahifaty/core/constants/fonts.dart';

import '../widgets/custom_text.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: text,
              color: const Color(0xff6B7785),
              fontSize: 14,
              fontWeight: AppFonts.semiBold,
              withBackground: false),
          Switch(
            value: false,
            onChanged: (value) => {},
            activeThumbColor: Colors.green, // color of the thumb when ON
            activeTrackColor: Colors.greenAccent, // color of the track when ON
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade400,
          ),
        ]);
  }
}
