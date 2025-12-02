import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sahifaty/models/surah.dart';

class SurahsController {
  Future<List<Surah>> loadSurahsByJuz(int juz) async {
    // Load file from assets
    final String response =
        await rootBundle.loadString('assets/json/data.json');

    // Decode JSON — your root is a map, not a list
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract the 'data' array
    final List<dynamic> ayahs = jsonData['data'];

    // Filter and map to Surah objects
    final List<Surah> allSurahs = ayahs
        .where((item) => item['juz'] == juz)
        .map((item) => Surah.fromJson(item['surah']))
        .toList();

    // ✅ Remove duplicates based on `id`
    final uniqueSurahs = {
      for (var surah in allSurahs) surah.id: surah,
    }.values.toList();

    return uniqueSurahs;
  }

  Future<List<Surah>> loadSurahsByHizb(int hizb) async {
    // Load file from assets
    final String response =
    await rootBundle.loadString('assets/json/data.json');

    // Decode JSON — your root is a map, not a list
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract the 'data' array
    final List<dynamic> ayahs = jsonData['data'];

    // Filter and map to Surah objects
    final List<Surah> allSurahs = ayahs
        .where((item) => item['hizb'] == hizb)
        .map((item) => Surah.fromJson(item['surah']))
        .toList();

    // ✅ Remove duplicates based on `id`
    final uniqueSurahs = {
      for (var surah in allSurahs) surah.id: surah,
    }.values.toList();

    return uniqueSurahs;
  }

}
