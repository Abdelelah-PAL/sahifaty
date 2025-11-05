import 'dart:convert';
import 'package:sahifaty/services/sahifaty_api.dart';

class SurahsServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<Map<String, dynamic>> getSurahsByJuz(int juz) async {
    try {
      int limit = 100;
      final res = await _sahifatyApi.get('surahs?juz=$juz&limit=$limit');

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
