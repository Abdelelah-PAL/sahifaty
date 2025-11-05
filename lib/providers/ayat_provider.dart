import 'package:flutter/material.dart';
import 'package:sahifaty/services/ayat_services.dart';
import '../models/ayat.dart';

class AyatProvider with ChangeNotifier {
  List<Ayat> quickQuestionsAyat = [];
  List<Ayat> surahAyat = [];
  int quickQuestionsLevelTotalPages = 1;
  int quickQuestionsLevelTotalCount = 1;
  int evaluatedVersesCount = 0;
  int surahAyatTotalPages = 1;
  int surahAyatTotalCount = 1;
  bool isLoading = false;
  Map<int, String> selectedValues = {};
  Map<int, Color> selectedColors = {};
  final AyatServices _ayatServices = AyatServices();

  Future<void> getQuickQuestionsAyatByLevel(int level, int page) async {
    setLoading();
    var res = await _ayatServices.getQuickQuestionsAyatByLevel(level, page);

    var data = res['data'];
    if (data is! List) {
      throw Exception('Unexpected response format: expected a list');
    }
    quickQuestionsAyat = data.map<Ayat>((ayah) => Ayat.fromJson(ayah)).toList();
    quickQuestionsLevelTotalPages = res['totalPages'];
    quickQuestionsLevelTotalCount = res['total'];
    for (var ayah in quickQuestionsAyat) {
      if (ayah.userEvaluation != null && ayah.userEvaluation!.evaluation!.id! > 0) {
        evaluatedVersesCount++;
      }
    }
    resetLoading();
  }

  Future<void> getAyatBySurahId(int surahId) async {
    setLoading();
    var res = await _ayatServices.getAyatBySurahId(surahId);
    var data = res['data'];
    if (data is! List) {
      throw Exception('Unexpected response format: expected a list');
    }
    surahAyat = data.map<Ayat>((ayah) => Ayat.fromJson(ayah)).toList();
    surahAyatTotalPages = res['totalPages'];
    surahAyatTotalCount = res['total'];
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

  void incrementEvaluatedVersesCount() {
    evaluatedVersesCount++;
    notifyListeners();
  }
  void resetEvaluatedVersesCount() {
    evaluatedVersesCount = 0;
    notifyListeners();
  }


  void selectOption(int index, String value, Color color) {
    selectedValues[index] = value;
    selectedColors[index] = color;
    notifyListeners();
  }

  String? getSelectedValue(int index) => selectedValues[index];

  Color getSelectedColor(int index)  {
    return selectedColors[index] ?? Colors.grey;
}

  void resetSelections() {
    selectedValues.clear();
    selectedColors.clear();
    notifyListeners();
  }

}
