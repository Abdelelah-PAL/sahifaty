import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    required this.width,
    required this.height,
    this.icon,
  });

  final VoidCallback onPressed;
  final String? text;
  final double width;
  final double height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          padding: EdgeInsets.zero, // remove default padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Center(
          child: icon != null
              ? Icon(
            icon,
            size: 20,
            color: Colors.white,
          )
              : text != null
              ? CustomText(
            text: text!,
            withBackground: false,
            fontSize: 14,
            color: Colors.white,
          )
              : null,
        ),
      ),
    );
  }
}

