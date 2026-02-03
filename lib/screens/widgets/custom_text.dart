import 'package:flutter/material.dart';
import 'package:sahifaty/core/constants/fonts.dart';

import '../../core/constants/colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.structHeight,
      this.structLeading,
      this.fontSize,
      this.textHeight,
      required this.withBackground,
      this.color,
      this.fontWeight,
      this.textAlign});

  final String text;
  final double? structHeight;
  final double? structLeading;
  final double? fontSize;
  final double? textHeight;
  final bool withBackground;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: withBackground ?  AppColors.primaryPurple : Colors.transparent,
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        // maxLines: null,
        // softWrap: true,
        // overflow: TextOverflow.visible,
        textAlign: textAlign ?? TextAlign.center,
        strutStyle: StrutStyle(
          forceStrutHeight: true,
          height: structHeight,
          leading: structLeading,
        ),
        style: TextStyle(
          fontSize: fontSize ?? 18,
          height: textHeight ?? 1,
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF000000),
          fontWeight: fontWeight ?? AppFonts.normal,
          fontFamily: 'roboto',
        ),
      ),
    );
  }
}
