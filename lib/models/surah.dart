class Surah {
  String? _id;
  String? nameAr;
  int? ayahCount;


  Surah({
    String? id,
    this.nameAr,
    this.ayahCount,
  }) : _id = id;

  String? get id => _id;

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['_id'],
      nameAr: json['nameAr'],
      ayahCount: json['ayahCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'nameAr': nameAr,
      'ayahCount': ayahCount,
    };
  }
}
