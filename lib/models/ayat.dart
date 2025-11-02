import 'package:sahifaty/models/school_level.dart';
import 'package:sahifaty/models/surah.dart';

class Ayat {
  int? _id;
  String text;
  int ayahNo;
  int juz;
  int hizb;
  int hizbQuarter;
  int wordCount;
  int letterCount;
  double weight;
  String ayahType;
  List<SchoolLevel>? schoolLevels;
  List<int>? subjects;
  Surah surah;

  Ayat({
    int? id,
    required this.text,
    required this.ayahNo,
    required this.juz,
    required this.hizb,
    required this.hizbQuarter,
    required this.wordCount,
    required this.letterCount,
    required this.weight,
    required this.ayahType,
    this.schoolLevels,
    this.subjects,
    required this.surah,
  }) : _id = id;

  int? get id => _id;

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      id: json['_id'],
      ayahNo: json['ayahNo'],
      text: json['text'],
      juz: json['juz'],
      hizb: json['hizb'],
      hizbQuarter: json['hizbQuarter'],
      wordCount: json['wordCount'],
      letterCount: json['letterCount'],
      weight: json['weight'],
      ayahType: json['ayahType'],
      schoolLevels: json['schoolLevels'] != null
          ? (json['schoolLevels'] as List)
              .map((e) => SchoolLevel.fromJson(e))
              .toList()
          : [],
      subjects:
          json['subjects'] != null ? List<int>.from(json['subjects']) : [],
      surah: Surah.fromJson(json['surah']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'ayahNo': ayahNo,
      'text': text,
      'juz': juz,
      'hizb': hizb,
      'hizbQuarter': hizbQuarter,
      'wordCount': wordCount,
      'letterCount': letterCount,
      'weight': weight,
      'ayahType': ayahType,
      'schoolLevels': schoolLevels?.map((level) => level.toMap()).toList(),
      'subjects': subjects,
      'surah': surah.toMap(),
    };
  }
}
