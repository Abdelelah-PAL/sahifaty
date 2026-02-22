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
      this.textAlign,
      this.maxLines,
      this.overflow});

  final String text;
  final double? structHeight;
  final double? structLeading;
  final double? fontSize;
  final double? textHeight;
  final bool withBackground;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: withBackground ?  AppColors.primaryPurple : Colors.transparent,
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        maxLines: maxLines,
        softWrap: true,
        overflow: overflow,
        textAlign: textAlign ?? TextAlign.center,
        strutStyle: StrutStyle(
          forceStrutHeight: true,
          height: structHeight,
          leading: structLeading,
        ),
        style: TextStyle(
          fontSize: fontSize ?? 16,
          height: textHeight ?? 1,
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF000000),
          fontWeight: fontWeight ?? AppFonts.normal,
          fontFamily: 'roboto',
        ),
      ),
    );
  }
}
