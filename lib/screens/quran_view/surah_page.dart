import 'package:flutter/material.dart';
import 'package:sahifaty/controllers/categories.dart';
import 'package:sahifaty/screens/widgets/custom_ayat_text.dart';

class SurahPage extends StatelessWidget {
  SurahPage({super.key});


  final List<Map<String, dynamic>> ayahData = [
    {'text': "الحَمدُ لِلَهِ رَبّ العالَمِينْ", 'category': Categories.desire},
    {'text': "الرَّحمنِ الرَّحِيمْ", 'category': Categories.strong},
    {'text': "مالِكِ يَوْمِ الدِّينْ", 'category': Categories.easy},
    {
      'text': "إِيّاكَ نعبدُ وإِيّاكَ نَسْتَعينْ",
      'category': Categories.strong
    },
    {
      'text': "اِهْدِنا الصّرَاطَ المُسْتَقِيم",
      'category': Categories.revision
    },
    {'text': "صِراطَ الّذينَ أنْعَمتَ عَلَيهِم", 'category': Categories.hard},
    {'text': "غَيْرِ المَغْضُوبِ عَلَيهِم", 'category': Categories.hard},
    {'text': "ولا الضّالِينْ", 'category': Categories.strong},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سورة الفاتحة"),
        // optional: replace with dynamic name
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 0,
            runSpacing: 4,
            children: ayahData.map((ayah) {
              return CustomAyatText(
                text: ayah['text'],
                category: ayah['category'],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
