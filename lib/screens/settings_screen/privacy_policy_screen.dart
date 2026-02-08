import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/colors.dart';
import '../widgets/custom_back_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            leading: const CustomBackButton(),
            title: Text(
              "privacy_policy_title".tr,
              style: const TextStyle(color: AppColors.blackFontColor),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "privacy_policy_last_update".tr,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "privacy_policy_intro".tr,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: AppColors.blackFontColor,
              ),
            ),
            const SizedBox(height: 25),
            _buildSection(
              "privacy_policy_section_1_title".tr,
              "",
            ),
            _buildSubSection(
              "privacy_policy_section_1_a_title".tr,
              "privacy_policy_section_1_a_content".tr,
            ),
            _buildSubSection(
              "privacy_policy_section_1_b_title".tr,
              "privacy_policy_section_1_b_content".tr,
            ),
            _buildSubSection(
              "privacy_policy_section_1_c_title".tr,
              "privacy_policy_section_1_c_content".tr,
            ),
            const SizedBox(height: 20),
            _buildSection(
              "privacy_policy_section_2_title".tr,
              "privacy_policy_section_2_content".tr,
            ),
            _buildSection(
              "privacy_policy_section_3_title".tr,
              "privacy_policy_section_3_content".tr,
            ),
            _buildSection(
              "privacy_policy_section_4_title".tr,
              "privacy_policy_section_4_content".tr,
            ),
            _buildSection(
              "privacy_policy_section_5_title".tr,
              "privacy_policy_section_5_content".tr,
            ),
            _buildSection(
              "privacy_policy_section_6_title".tr,
              "privacy_policy_section_6_content".tr,
            ),
            _buildSection(
              "privacy_policy_section_7_title".tr,
              "privacy_policy_section_7_content".tr,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryPurple,
            ),
          ),
          if (content.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: AppColors.blackFontColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackFontColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.blackFontColor,
            ),
          ),
        ],
      ),
    );
  }
}
