class Ayat {
  String? _id;
  String text;
  int ayahNo;
  int juz;
  int hizb;
  int hizbQuarter;
  int wordCount;
  int letterCount;
  double weight;
  String ayahType;


  Ayat({
    String? id,
    required this.text,
    required this.ayahNo,
    required this.juz,
    required this.hizb,
    required this.hizbQuarter,
    required this.wordCount,
    required this.letterCount,
    required this.weight,
    required this.ayahType,
  }) : _id = id;

  String? get id => _id;

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
    };
  }
}
