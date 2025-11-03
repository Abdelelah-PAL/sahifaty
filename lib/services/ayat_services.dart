import 'dart:core';
import 'package:sahifaty/services/sahifaty_api.dart';

class AyatServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<dynamic> getQuickQuestionsAyatByLevel(int level, int page) async {
    try {
      int limit = 10;
      var res = await _sahifatyApi
          .get('ayat?page=$page&limit=$limit&schoolId=1&level=$level');
      return res;
    } catch (ex) {
      rethrow;
    }
  }
}
