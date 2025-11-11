import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sahifaty/controllers/general_controller.dart';
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
      if (ayah.userEvaluation != null &&
          ayah.userEvaluation!.evaluation!.id! > 0) {
        evaluatedVersesCount++;
      }
    }
    resetLoading();
  }

  Future<void> getAyatBySurahId(int surahId) async {
    setLoading();

    try {
      Map<String, dynamic> res;
      final hasConnection = await GeneralController().checkConnectivity();

      if (!hasConnection) {
        // 📴 No internet → Load from local JSON
        final String jsonString =
            await rootBundle.loadString('assets/json/data.json');
        final List<dynamic> allAyat = json.decode(jsonString);

        // 🔍 Filter by surah.id
        final filteredAyat = allAyat.where((ayah) {
          final surah = ayah['surah'];
          return surah != null && surah['id'] == surahId;
        }).toList();

        res = {
          'data': filteredAyat,
          'totalPages': 1,
          'total': filteredAyat.length,
        };
      } else {
        // 🌐 Online → Load from API
        res = await _ayatServices.getAyatBySurahId(surahId);
      }

      var data = res['data'];
      if (data is! List) {
        throw Exception('Unexpected response format: expected a list');
      }

      // 🧩 Map to your Ayat model
      surahAyat = data.map<Ayat>((ayah) => Ayat.fromJson(ayah)).toList();
      surahAyatTotalPages = res['totalPages'];
      surahAyatTotalCount = res['total'];
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error loading Ayat: $e");
      }
    } finally {
      resetLoading();
    }
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
}
