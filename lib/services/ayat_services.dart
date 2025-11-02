import 'dart:core';
import 'package:sahifaty/services/sahifaty_api.dart';
import '../models/ayat.dart';

class AyatServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<dynamic> getQuickQuestionsAyatByLevel(int level, int page) async {
    try {
      int limit = 10;
      var res = await _sahifatyApi
          .get('ayat?page=$page&limit=$limit&schoolId=1&level=$level');

      // // Extract the actual list of ayat (adjust the key if needed)
      // var data = res['data'] ?? res;
      //
      // if (data is! List) {
      //   throw Exception('Unexpected response format: expected a list');
      // }
      //
      // List<Ayat> quickQuestionsAyat =
      //     data.map<Ayat>((ayah) => Ayat.fromJson(ayah)).toList();
      return res;
    } catch (ex) {
      rethrow;
    }
  }
}
