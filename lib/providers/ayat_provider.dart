import 'package:flutter/material.dart';
import 'package:sahifaty/services/ayat_services.dart';
import '../models/ayat.dart';

class AyatProvider with ChangeNotifier {
  List<Ayat> quickQuestionsAyat = [];
  int quickQuestionsLevelTotalPages = 1;
  int quickQuestionsLevelTotalCount = 1;
  int evaluatedVersesCount = 1;
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

  void selectOption(int index, String value, Color color) {
    selectedValues[index] = value;
    selectedColors[index] = color;
    notifyListeners();
  }

  String? getSelectedValue(int index) => selectedValues[index];

  Color getSelectedColor(int index) => selectedColors[index] ?? Colors.grey;

  void resetSelections() {
    selectedValues.clear();
    selectedColors.clear();
    notifyListeners();
  }
}

