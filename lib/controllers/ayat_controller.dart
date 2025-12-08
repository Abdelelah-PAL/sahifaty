import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/ayat.dart';

class AyatController {
  Future<List<Ayat>> loadAyatBySurah(int surahId) async {
    try{
      // Load file from assets
      final String response =
          await rootBundle.loadString('assets/json/data.json');

      // Decode JSON — your root is a map, not a list
      final Map<String, dynamic> jsonData = json.decode(response);

      // Extract the 'data' array
      final List<dynamic> ayahs = jsonData['data'];
      // Filter and map to Surah objects
      final List<Ayat> surahAyat = ayahs
          .where((item) => item['surah']['id'] == surahId)
          .map((item) => Ayat.fromJson(item))
          .toList();

      return surahAyat;
    }
    catch(e) {
      rethrow;
    }
  }

  Future<List<Ayat>> loadAyatByHizb(int hizb) async {
    // Load file from assets
    final String response =
    await rootBundle.loadString('assets/json/data.json');

    // Decode JSON — your root is a map, not a list
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract the 'data' array
    final List<dynamic> ayahs = jsonData['data'];

    // Filter and map to Surah objects
    final List<Ayat> hizbAyat = ayahs
        .where((item) => item['hizb'] == hizb)
        .map((item) => Ayat.fromJson(item))
        .toList();


    return hizbAyat;
  }

  Future<List<Ayat>> loadAyatByHizbQuarter(int hizbQuarter) async {
    // Load file from assets
    final String response =
        await rootBundle.loadString('assets/json/data.json');

    // Decode JSON — your root is a map, not a list
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract the 'data' array
    final List<dynamic> ayahs = jsonData['data'];


    // Filter and map to Surah objects
    final List<Ayat> hizbQuarterAyat = ayahs
        .where((item) => item['hizbQuarter'] == hizbQuarter)
        .map((item) => Ayat.fromJson(item))
        .toList();

    return hizbQuarterAyat;
  }

  Future<List<Ayat>> loadAyatByJuz(int juz) async {
    // Load file from assets
    final String response =
        await rootBundle.loadString('assets/json/data.json');

    // Decode JSON — your root is a map, not a list
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract the 'data' array
    final List<dynamic> ayahs = jsonData['data'];

    // Filter and map to Surah objects
    final List<Ayat> juzAyat = ayahs
        .where((item) => item['juz'] == juz)
        .map((item) => Ayat.fromJson(item))
        .toList();

    return juzAyat;
  }

  Future<List<Ayat>> loadAyatByRange(int surahId, int startAyah, int endAyah) async {
    if (kDebugMode) {
      print("AyatController: loadAyatByRange called with surahId: $surahId, start: $startAyah, end: $endAyah");
    }
    // Load file from assets
    final String response =
        await rootBundle.loadString('assets/json/data.json');

    // Decode JSON — your root is a map, not a list
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract the 'data' array
    final List<dynamic> ayahs = jsonData['data'];
    if (kDebugMode) {
      print("AyatController: Loaded ${ayahs.length} ayahs from JSON");
    }

    // Filter and map to Surah objects
    final List<Ayat> rangeAyat = ayahs
        .where((item) {
            final itemSurahId = item['surah']['id'];
            final itemAyahNo = item['ayahNo'];
            final match = itemSurahId == surahId &&
            itemAyahNo >= startAyah &&
            itemAyahNo <= endAyah;
            if (match) {
               // print("Found match: Surah $itemSurahId, Ayah $itemAyahNo");
            }
            return match;
        })
        .map((item) => Ayat.fromJson(item))
        .toList();
    
    if (kDebugMode) {
      print("AyatController: Returning ${rangeAyat.length} ayahs");
    }
    return rangeAyat;
  }

}
