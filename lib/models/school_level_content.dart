class SchoolLevelContent {
  String? _id;
  String type;
  int? surahId;
  int? hizb;
  int? startAyah;
  int? endAyah;
  int? juz;

  SchoolLevelContent({
    String? id,
    required this.type,
    this.surahId,
    this.hizb,
    this.startAyah,
    this.endAyah,
    this.juz,

  }) : _id = id;

  String? get id => _id;

  factory SchoolLevelContent.fromJson(Map<String, dynamic> json) {
    return SchoolLevelContent(
      id: json['_id'],
      type: json['type'] ?? json['name'],
      surahId: json['surahId'],
      hizb: json['hizb'],
      startAyah: json['startAyah'],
      endAyah: json['endAyah'],
      juz: json['juz']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'name': type,
      'surahId': surahId,
      'hizb': hizb,
      'startAyah': startAyah,
      'endAyah': endAyah,
      'juz': juz
    };
  }
}
