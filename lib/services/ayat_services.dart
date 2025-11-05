import 'dart:convert';
import 'package:sahifaty/services/sahifaty_api.dart';

class AyatServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<Map<String, dynamic>> getQuickQuestionsAyatByLevel(int level, int page) async {
    try {
      int limit = 10;
      final res = await _sahifatyApi.get('ayat?page=$page&limit=$limit&schoolId=1&level=$level');

      // Decode JSON body
      if (res.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(res.body);
        return data;
      } else {
        throw Exception('Failed to load ayat');
      }
    } catch (ex) {
      rethrow;
    }
  }
  Future<Map<String, dynamic>> getAyatBySurahId(int surahId) async {
    try {
      int limit = 1000;
      final res = await _sahifatyApi.get('ayat?surahId=$surahId&limit=$limit');

      // Decode JSON body
      if (res.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(res.body);
        return data;
      } else {
        throw Exception('Failed to load ayat');
      }
    } catch (ex) {
      rethrow;
    }
  }
}
