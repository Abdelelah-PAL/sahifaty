import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';

class CustomAuthDivider extends StatelessWidget {
  const CustomAuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.getProportionalWidth(40)),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.authDividerColor,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionalWidth(30),
              ),
              child: const Text("أو")),
          const Expanded(
            child: Divider(
              color: AppColors.authDividerColor,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
          ),
        ],
      ),
    );
  }
}
