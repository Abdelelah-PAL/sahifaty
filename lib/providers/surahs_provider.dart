import 'package:flutter/material.dart';
import 'package:sahifaty/models/surah.dart';
import 'package:sahifaty/services/surahs_services.dart';

import '../controllers/surahs_controller.dart';

class SurahsProvider with ChangeNotifier {
  List<Surah> surahsByJuz = [];
  int totalSurahs = 1;
  bool isLoading = false;
  final SurahsServices _surahsServices = SurahsServices();
  final Map<int, List<Surah>> hizbSurahs = {};

  Future<void> getSurahsByJuz(int juz) async {
    setLoading();
    var res = await _surahsServices.getSurahsByJuz(juz);
    var data = res['data'];
    if (data is! List) {
      throw Exception('Unexpected response format: expected a list');
    }
    surahsByJuz = data.map<Surah>((surah) => Surah.fromJson(surah)).toList();
    totalSurahs = res['total'];
    resetLoading();
  }

  Future<void> loadAllHizbSurahs(List<Map<String, dynamic>> hizbs) async {
    notifyListeners();
    isLoading = true;

    final futures = hizbs.map((hizb) async {
      final surahs =
      await SurahsController().loadSurahsByHizb(hizb['id']);
      hizbSurahs[hizb['id']] = surahs;
    });

    await Future.wait(futures);

    isLoading = false;

    notifyListeners();

  }
  void setLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetLoading() {
    isLoading = false;
    notifyListeners();
  }
}

