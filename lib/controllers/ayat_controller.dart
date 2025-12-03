import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ayat.dart';

class AyatController {
  Future<List<Ayat>> loadAyatBySurah(int surahId) async {
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

}
