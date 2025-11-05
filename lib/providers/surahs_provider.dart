import 'package:flutter/material.dart';
import 'package:sahifaty/models/surah.dart';
import 'package:sahifaty/services/ayat_services.dart';
import 'package:sahifaty/services/surahs_services.dart';
import '../models/ayat.dart';

class SurahsProvider with ChangeNotifier {
  List<Surah> surahsByJuz = [];
  int totalSurahs = 1;
  bool isLoading = false;
  final SurahsServices _surahsServices = SurahsServices();

  Future<void> getSurahsByJuz(int juz) async {
    print(juz);
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

  void setLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetLoading() {
    isLoading = false;
    notifyListeners();
  }
}

