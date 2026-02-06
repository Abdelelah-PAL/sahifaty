import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuranViewer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuranViewer extends StatelessWidget {
  const QuranViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quran Viewer")),
      body: PageView.builder(
        itemCount: quran.totalSurahCount,
        itemBuilder: (context, surahIndex) {
          final surahNumber = surahIndex + 1;
          final totalAyahs = quran.getVerseCount(surahNumber);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      quran.getSurahNameArabic(surahNumber),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (int verse = 1; verse <= totalAyahs; verse++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        '${quran.getVerse(surahNumber, verse)} ﴿$verse﴾',
                        style: const TextStyle(fontSize: 24, height: 1.7),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
