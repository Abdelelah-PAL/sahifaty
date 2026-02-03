import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controllers/general_controller.dart';
import '../../core/utils/size_config.dart';
import '../../providers/evaluations_provider.dart';
import '../../providers/school_provider.dart';
import '../../providers/users_provider.dart';
import '../sahifa_screen/sahifa_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'content_item_card.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchoolProvider schoolProvider = Provider.of<SchoolProvider>(context);
    EvaluationsProvider evaluationsProvider =
        Provider.of<EvaluationsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text:
              ' تقييم المستوى  ${GeneralController().getStringLevel(selectedIndex + 1)} (${schoolProvider.quickQuestionsSchool.levels[selectedIndex].name!})',
          fontSize: 16,
          withBackground: true,
          color: const Color(0xFFFFFFFF),
        ),
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.getProportionalHeight(0),
              horizontal: SizeConfig.getProportionalHeight(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: schoolProvider.quickQuestionsSchool
                      .levels[selectedIndex].content.length,
                  itemBuilder: (context, index) {
                    return ContentItemCard(
                      content: schoolProvider.quickQuestionsSchool
                          .levels[selectedIndex].content[index],
                      index: index,
                    );
                  },
                ),
              ),
              SizeConfig.customSizedBox(null, 15, null),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getProportionalWidth(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                      onPressed: () async {
                        UsersProvider usersProvider =
                            context.read<UsersProvider>();
                        await evaluationsProvider
                            .getQuranChartData(usersProvider.selectedUser!.id);
                        Get.to(const SahifaScreen());
                      },
                      text: "تخطّي",
                      width: 60,
                      height: 35,
                      isDisabled: false,
                    ),
                    SizeConfig.customSizedBox(80, null, null),
                    CustomButton(
                        onPressed: () {
                          if (selectedIndex > 0) {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                            );
                            setState(() {
                              selectedIndex = selectedIndex - 1;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("أنت في المستوى الأول")));
                          }
                        },
                        text: " المستوى السابق",
                        width: 120,
                        height: 35,
                        isDisabled: false),
                    SizeConfig.customSizedBox(80, null, null),
                    CustomButton(
                        onPressed: () {
                          if (selectedIndex + 1 <
                              schoolProvider
                                  .quickQuestionsSchool.levels.length) {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                            );
                            setState(() {
                              selectedIndex = selectedIndex + 1;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("انتهت الأسئلة")));
                          }
                        },
                        text: " المستوى التالي",
                        width: 120,
                        height: 35,
                        isDisabled: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
