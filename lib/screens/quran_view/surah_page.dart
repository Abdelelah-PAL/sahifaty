import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:sahifaty/screens/widgets/custom_text.dart';

class SurahPage extends StatelessWidget {
  final int surahNumber;

  const SurahPage({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final surahNameArabic = quran.getSurahNameArabic(surahNumber);
    final verseCount = quran.getVerseCount(surahNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(surahNameArabic),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: verseCount,
          itemBuilder: (context, index) {
            final verseNumber = index + 1;
            final verseText =
                quran.getVerse(surahNumber, verseNumber, verseEndSymbol: true);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomText(
                text: verseText,
                withBackground: false,
                fontSize: 22,
                structHeight: 1.8,
              ),
            );
          },
        ),
      ),
    );
  }
}
