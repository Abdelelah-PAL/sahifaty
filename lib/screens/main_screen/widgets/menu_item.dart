import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahifaty/core/constants/fonts.dart';
import 'package:sahifaty/providers/general_provider.dart';
import '../../widgets/custom_text.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final ValueChanged<bool> onChanged;
  final int index;

  const MenuItem({
    super.key,
    required this.text,
    required this.onChanged,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(context);
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
          value: index == 1
              ? generalProvider.thirdsMenuItem
              : index == 2
                  ? generalProvider.partsMenuItem
                  : generalProvider.assessmentMenuItem,
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
